<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detay.aspx.cs" Inherits="YemekTarif.Detay" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tarif Detayı</title>
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
            max-width: 800px; 
            margin: 0 auto; 
        }
        .btn-back { 
            display: inline-block; 
            margin-bottom: 20px; 
            padding: 10px 20px; 
            background: rgba(255, 255, 255, 0.9); 
            color: #fc6076; 
            text-decoration: none; 
            border-radius: 50px; 
            font-weight: 600; 
            transition: 0.3s; 
            box-shadow: 0 4px 15px rgba(0,0,0,0.1); 
        }
        .btn-back:hover { 
            background: #fff; 
            transform: scale(1.05); 
        }
        .panel { 
            background: rgba(255, 255, 255, 0.95); 
            border-radius: 20px; 
            padding: 40px; 
            box-shadow: 0 15px 40px rgba(0,0,0,0.2); 
        }
        .img-container {
            width: 100%;
            height: 400px;
            border-radius: 15px;
            overflow: hidden;
            margin-bottom: 30px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }
        .img-container img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
        }
        h1 { 
            color: #2c3e50; 
            margin-top: 0; 
            font-size: 2.2rem;
            font-weight: 600;
        }
        hr {
            border: 0; 
            height: 1px; 
            background: #e1e5eb; 
            margin: 20px 0;
        }
        .detay-metni { 
            font-size: 1.1rem; 
            line-height: 1.8; 
            color: #444; 
            white-space: pre-wrap; 
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <a href="Default.aspx" class="btn-back">&larr; Ana Ekrana Dön</a>
            
            <div class="panel">
                <div class="img-container">
                    <asp:Image ID="imgFoto" runat="server" />
                </div>
                
                <h1><asp:Literal ID="litBaslik" runat="server"></asp:Literal></h1>
                <hr />
                
                <div class="detay-metni">
                    <asp:Literal ID="litDetay" runat="server"></asp:Literal>
                </div>
            </div>
        </div>
    </form>
</body>
</html>