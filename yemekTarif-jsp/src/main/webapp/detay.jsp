<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <title>Tarif Detayı</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 40px 20px; background: linear-gradient(135deg, #ff9a44 0%, #fc6076 100%); min-height: 100vh; color: #333; }
        .container { max-width: 800px; margin: 0 auto; }
        .btn-back { display: inline-block; margin-bottom: 20px; padding: 10px 20px; background: rgba(255, 255, 255, 0.9); color: #fc6076; text-decoration: none; border-radius: 50px; font-weight: 600; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .panel { background: rgba(255, 255, 255, 0.95); border-radius: 20px; padding: 40px; box-shadow: 0 15px 40px rgba(0,0,0,0.2); }
        .img-container { width: 100%; height: 400px; border-radius: 15px; overflow: hidden; margin-bottom: 30px; }
        .img-container img { width: 100%; height: 100%; object-fit: cover; }
        h1 { color: #2c3e50; margin-top: 0; font-size: 2.2rem; }
        hr { border: 0; height: 1px; background: #e1e5eb; margin: 20px 0; }
        .detay-metni { font-size: 1.1rem; line-height: 1.8; color: #444; white-space: pre-wrap; }
    </style>
</head>
<body>
<div class="container">
    <a href="index.jsp" class="btn-back">&larr; Ana Ekrana Dön</a>
    <div class="panel">
        <%
            String tarifId = request.getParameter("id");
            if(tarifId != null) {
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/yemek_tarif_db", "postgres", "6190");
                    PreparedStatement pst = conn.prepareStatement("SELECT * FROM Tarifler WHERE id = ?");
                    pst.setInt(1, Integer.parseInt(tarifId));
                    ResultSet rs = pst.executeQuery();

                    if(rs.next()) {
                        String baslik = rs.getString("baslik");
                        String detay = rs.getString("detay");
                        String foto = rs.getString("fotograf_url");
                        if(foto == null || foto.trim().isEmpty()) foto = "https://images.unsplash.com/photo-1495521821757-a1efb6729352?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80";
        %>
        <div class="img-container">
            <img src="<%=foto%>" alt="Fotoğraf">
        </div>
        <h1><%=baslik%></h1>
        <hr />
        <div class="detay-metni"><%=detay%></div>
        <%
                    }
                    rs.close(); pst.close(); conn.close();
                } catch(Exception e) { out.println("Hata oluştu."); }
            } else { response.sendRedirect("index.jsp"); }
        %>
    </div>
</div>
</body>
</html>