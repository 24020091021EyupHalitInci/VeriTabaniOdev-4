<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // Veritabanı Bilgileri
    String dbUrl = "jdbc:postgresql://localhost:5432/yemek_tarif_db";
    String dbUser = "postgres";
    String dbPass = "6190";

    request.setCharacterEncoding("UTF-8");

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);

        // --- CREATE (Ekleme) ---
        if(request.getParameter("ekle") != null) {
            String baslik = request.getParameter("baslik");
            String foto = request.getParameter("foto_url");
            String detay = request.getParameter("detay");
            PreparedStatement pst = conn.prepareStatement("INSERT INTO Tarifler (baslik, detay, fotograf_url) VALUES (?, ?, ?)");
            pst.setString(1, baslik); pst.setString(2, detay); pst.setString(3, foto);
            pst.executeUpdate(); pst.close();
            response.sendRedirect("crud.jsp");
            return;
        }

        // --- UPDATE (Güncelleme) ---
        if(request.getParameter("guncelle") != null) {
            String id = request.getParameter("id");
            String baslik = request.getParameter("baslik");
            String foto = request.getParameter("foto_url");
            String detay = request.getParameter("detay");
            PreparedStatement pst = conn.prepareStatement("UPDATE Tarifler SET baslik=?, detay=?, fotograf_url=? WHERE id=?");
            pst.setString(1, baslik); pst.setString(2, detay); pst.setString(3, foto); pst.setInt(4, Integer.parseInt(id));
            pst.executeUpdate(); pst.close();
            response.sendRedirect("crud.jsp");
            return;
        }

        // --- DELETE (Silme) ---
        if(request.getParameter("sil") != null) {
            String id = request.getParameter("sil");
            PreparedStatement pst = conn.prepareStatement("DELETE FROM Tarifler WHERE id=?");
            pst.setInt(1, Integer.parseInt(id));
            pst.executeUpdate(); pst.close();
            response.sendRedirect("crud.jsp");
            return;
        }
%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Tarif Yönetimi Paneli</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f0f2f5; margin: 0; padding: 30px; color: #333; }
        .nav { margin-bottom: 30px; } .nav a { text-decoration: none; color: #fff; background: #2c3e50; padding: 10px 20px; border-radius: 8px; }
        .container { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; max-width: 1400px; margin: 0 auto; }
        .panel { background: white; padding: 30px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.05); }
        h2 { margin-top: 0; color: #2c3e50; font-size: 1.5rem; margin-bottom: 25px; }
        input, textarea, button { width: 100%; margin-bottom: 20px; padding: 15px; border-radius: 10px; border: 1px solid #e1e5eb; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
        .btn-submit { background: #2ecc71; color: white; border: none; cursor: pointer; font-weight: 600; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f8f9fa; padding: 15px; text-align: left; border-bottom: 2px solid #e1e5eb; }
        td { padding: 15px; border-bottom: 1px solid #e1e5eb; }
        .action-links { display: flex; gap: 10px; }
        .action-links a, .action-links button { text-decoration: none; padding: 8px 16px; border-radius: 6px; font-weight: 500; cursor: pointer; border: none; font-family: 'Poppins', sans-serif; color: white;}
        .btn-edit { background: #f39c12; } .btn-delete { background: #e74c3c; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.4); justify-content: center; align-items: center; }
        .modal-content { background: #fff; padding: 30px; border-radius: 20px; width: 90%; max-width: 500px; position: relative; }
        .close-btn { position: absolute; top: 15px; right: 20px; font-size: 28px; cursor: pointer; }
    </style>
</head>
<body>
<div class="nav"><a href="index.jsp">&larr; Ana Ekrana Dön</a></div>
<div class="container">
    <div class="panel">
        <h2>✨ Yeni Tarif Ekle</h2>
        <form method="POST">
            <input type="text" name="baslik" placeholder="Yemek Adı" required>
            <input type="text" name="foto_url" placeholder="Fotoğraf URL">
            <textarea name="detay" rows="6" placeholder="Tarif Detayları" required></textarea>
            <button type="submit" name="ekle" class="btn-submit">Tarifi Kaydet</button>
        </form>
    </div>
    <div class="panel">
        <h2>📋 Kayıtlı Tarifler</h2>
        <div style="overflow-x:auto;">
            <table>
                <tr><th>ID</th><th>Yemek Başlığı</th><th>İşlemler</th></tr>
                <%
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM Tarifler ORDER BY id DESC");
                    while(rs.next()) {
                %>
                <tr>
                    <td><strong>#<%=rs.getString("id")%></strong></td>
                    <td><%=rs.getString("baslik")%></td>
                    <td class="action-links">
                        <button type="button" class="btn-edit"
                                data-id="<%=rs.getString("id")%>"
                                data-baslik="<%=rs.getString("baslik")%>"
                                data-foto="<%=rs.getString("fotograf_url")%>"
                                data-detay="<%=rs.getString("detay")%>"
                                onclick="openModal(this)">Düzenle</button>
                        <a href="?sil=<%=rs.getString("id")%>" class="btn-delete" onclick="return confirm('Emin misin?');">Sil</a>
                    </td>
                </tr>
                <% } rs.close(); stmt.close(); conn.close(); %>
            </table>
        </div>
    </div>
</div>

<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeModal()">&times;</span>
        <h2>✏️ Tarifi Güncelle</h2>
        <form method="POST">
            <input type="hidden" name="id" id="modal_id">
            <input type="text" name="baslik" id="modal_baslik" required>
            <input type="text" name="foto_url" id="modal_foto">
            <textarea name="detay" id="modal_detay" rows="6" required></textarea>
            <button type="submit" name="guncelle" class="btn-submit" style="background:#3498db;">Değişiklikleri Kaydet</button>
        </form>
    </div>
</div>

<script>
    function openModal(btn) {
        document.getElementById('modal_id').value = btn.getAttribute('data-id');
        document.getElementById('modal_baslik').value = btn.getAttribute('data-baslik');
        document.getElementById('modal_foto').value = btn.getAttribute('data-foto');
        document.getElementById('modal_detay').value = btn.getAttribute('data-detay');
        document.getElementById('editModal').style.display = 'flex';
    }
    function closeModal() { document.getElementById('editModal').style.display = 'none'; }
</script>
</body>
</html>
<%
    } catch(Exception e) { out.println("Hata: " + e.getMessage()); }
%>