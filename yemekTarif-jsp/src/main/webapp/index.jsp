<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yemek Tarifleri | Ana Ekran</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 40px 20px;
            background: linear-gradient(135deg, #ff9a44 0%, #fc6076 100%);
            min-height: 100vh;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding: 20px 30px;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.15);
            backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
        }

        .header h1 {
            margin: 0;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
        }

        .card {
            background: rgba(255, 255, 255, 0.6);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.1);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.4);
            border-radius: 20px;
            padding: 20px;
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 40px 0 rgba(31, 38, 135, 0.2);
            background: rgba(255, 255, 255, 0.8);
        }

        .card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 15px;
        }

        .card h2 {
            margin: 0 0 10px 0;
            font-size: 1.4rem;
            color: #2c3e50;
        }

        .card p {
            color: #555;
            font-size: 0.95rem;
            line-height: 1.5;
            flex-grow: 1;
            margin-bottom: 20px;
        }

        .btn {
            padding: 12px 25px;
            background: rgba(255, 255, 255, 0.9);
            color: #fc6076;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: 0.3s;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .btn:hover {
            background: #fff;
            transform: scale(1.05);
        }

        .btn-detail {
            background: #fc6076;
            color: white;
            text-align: center;
            display: block;
            width: 100%;
            box-sizing: border-box;
        }

        .btn-detail:hover {
            background: #ff9a44;
            color: white;
            transform: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🍽️ Günün Tarifleri</h1>
        <a href="crud.jsp" class="btn">Tarif Yönetimi (CRUD) ⚙️</a>
    </div>
    <div class="grid">
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            try {
                Class.forName("org.postgresql.Driver");
                // Şifre ve kullanıcı adını kendi PostgreSQL bilgilerinle değiştir!
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/yemek_tarif_db", "postgres", "6190");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM Tarifler ORDER BY id DESC");

                while (rs.next()) {
                    String id = rs.getString("id");
                    String baslik = rs.getString("baslik");
                    String detay = rs.getString("detay");
                    String foto = rs.getString("fotograf_url");

                    if (foto == null || foto.trim().isEmpty()) {
                        foto = "https://images.unsplash.com/photo-1495521821757-a1efb6729352?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80";
                    }

                    String kisaDetay = detay.length() > 100 ? detay.substring(0, 100) + "..." : detay;
        %>
        <div class="card">
            <img src="<%=foto%>" alt="Yemek">
            <h2><%=baslik%>
            </h2>
            <p><%=kisaDetay%>
            </p>
            <a href="detay.jsp?id=<%=id%>" class="btn btn-detail">Tarifi İncele 👀</a>
        </div>
        <%
                }
            } catch (Exception e) {
                out.println("<p>Hata: " + e.getMessage() + "</p>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("Bağlantı kapatılırken hata: " + e.getMessage());
                }
            }
        %>
    </div>
</div>
</body>
</html>