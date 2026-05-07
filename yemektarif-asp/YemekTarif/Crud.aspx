<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Crud.aspx.cs" Inherits="YemekTarif.Crud" %>

<!DOCTYPE html>
<html lang="tr">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tarif Yönetimi Paneli</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f0f2f5; margin: 0; padding: 30px; color: #333; }
        .nav { margin-bottom: 30px; }
        .nav a { text-decoration: none; color: #fff; background: #2c3e50; padding: 10px 20px; border-radius: 8px; transition: 0.3s; }
        .nav a:hover { background: #34495e; }
        .container { display: grid; grid-template-columns: 1fr 2fr; gap: 30px; max-width: 1400px; margin: 0 auto; }
        .panel { background: white; padding: 30px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05); }
        h2 { margin-top: 0; color: #2c3e50; font-size: 1.5rem; margin-bottom: 25px; }
        input, textarea, button { width: 100%; margin-bottom: 20px; padding: 15px; border-radius: 10px; border: 1px solid #e1e5eb; box-sizing: border-box; font-family: 'Poppins', sans-serif; background: #f8f9fa; }
        input:focus, textarea:focus { outline: none; border-color: #3498db; background: #fff; box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1); }
        .btn-submit { background: #2ecc71; color: white; border: none; cursor: pointer; font-weight: 600; font-size: 1rem; transition: 0.3s; }
        .btn-submit:hover { background: #27ae60; transform: translateY(-2px); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f8f9fa; padding: 15px; text-align: left; color: #7f8c8d; border-bottom: 2px solid #e1e5eb; }
        td { padding: 15px; border-bottom: 1px solid #e1e5eb; vertical-align: middle; }
        .action-links { display: flex; gap: 10px; align-items: center; }
        .action-links a, .action-links button, .btn-action { text-decoration: none; padding: 0 16px; border-radius: 6px; font-size: 0.85rem; font-weight: 500; cursor: pointer; border: none; font-family: 'Poppins', sans-serif; display: inline-flex; align-items: center; justify-content: center; height: 38px; box-sizing: border-box; margin: 0; transition: 0.2s ease; }
        .btn-edit { background: #f39c12; color: white; }
        .btn-delete { background: #e74c3c; color: white; }
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.4); backdrop-filter: blur(5px); justify-content: center; align-items: center; }
        .modal-content { background-color: #fff; padding: 30px; border-radius: 20px; width: 90%; max-width: 500px; box-shadow: 0 15px 50px rgba(0, 0, 0, 0.2); position: relative; animation: slideDown 0.3s ease-out; }
        .close-btn { position: absolute; top: 15px; right: 20px; font-size: 28px; font-weight: bold; color: #aaa; cursor: pointer; }
        .close-btn:hover { color: #333; }
        @keyframes slideDown { from { transform: translateY(-50px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
        @media (max-width: 900px) { .container { grid-template-columns: 1fr; } }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="nav">
            <a href="Default.aspx">&larr; Ana Ekrana Dön</a>
        </div>

        <div class="container">
            <div class="panel">
                <h2>✨ Yeni Tarif Ekle</h2>
                <asp:TextBox ID="txtBaslik" runat="server" placeholder="Yemek Adı" required="true"></asp:TextBox>
                <asp:TextBox ID="txtFotoUrl" runat="server" placeholder="Fotoğraf URL"></asp:TextBox>
                <asp:TextBox ID="txtDetay" runat="server" TextMode="MultiLine" Rows="6" placeholder="Tarif Detayları" required="true"></asp:TextBox>
                <asp:Button ID="btnEkle" runat="server" Text="Tarifi Kaydet" CssClass="btn-submit" OnClick="btnEkle_Click" />
            </div>

            <!-- KAYITLI TARİFLER PANeli -->
            <div class="panel">
                <h2>📋 Kayıtlı Tarifler</h2>
                <div style="overflow-x:auto;">
                    <table>
                        <tr>
                            <th width="5%">ID</th>
                            <th width="65%">Yemek Başlığı</th>
                            <th width="30%">İşlemler</th>
                        </tr>
                        <asp:Repeater ID="rptTarifler" runat="server" OnItemCommand="rptTarifler_ItemCommand">
                            <ItemTemplate>
                                <tr>
                                    <td><strong>#<%# Eval("id") %></strong></td>
                                    <td><%# Eval("baslik") %></td>
                                    <td class="action-links">
                                        <button type="button" class="btn-edit" 
                                            data-id='<%# Eval("id") %>' 
                                            data-baslik='<%# Eval("baslik") %>' 
                                            data-foto='<%# Eval("fotograf_url") %>' 
                                            data-detay='<%# Eval("detay") %>' 
                                            onclick="openModal(this)">Düzenle</button>
                                        
                                        <asp:LinkButton ID="btnSil" runat="server" CssClass="btn-delete btn-action" CommandName="Sil" CommandArgument='<%# Eval("id") %>' OnClientClick="return confirm('Silmek istediğine emin misin?');">Sil</asp:LinkButton>
                                    </td>
                                </tr>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
        </div>

        
        <div id="editModal" class="modal">
            <div class="modal-content">
                <span class="close-btn" onclick="closeModal()">&times;</span>
                <h2>✏️ Tarifi Güncelle</h2>
                <asp:HiddenField ID="hdnModalId" runat="server" ClientIDMode="Static" />
                <asp:TextBox ID="txtModalBaslik" runat="server" ClientIDMode="Static" required="true"></asp:TextBox>
                <asp:TextBox ID="txtModalFoto" runat="server" ClientIDMode="Static"></asp:TextBox>
                <asp:TextBox ID="txtModalDetay" runat="server" TextMode="MultiLine" Rows="6" ClientIDMode="Static" required="true"></asp:TextBox>
                <asp:Button ID="btnGuncelle" runat="server" Text="Değişiklikleri Kaydet" CssClass="btn-submit" Style="background: #3498db;" OnClick="btnGuncelle_Click" />
            </div>
        </div>
    </form>

    <script>
        function openModal(button) {
            document.getElementById('hdnModalId').value = button.getAttribute('data-id');
            document.getElementById('txtModalBaslik').value = button.getAttribute('data-baslik');
            document.getElementById('txtModalFoto').value = button.getAttribute('data-foto');
            document.getElementById('txtModalDetay').value = button.getAttribute('data-detay');

            document.getElementById('editModal').style.display = 'flex';
        }

        function closeModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        window.onclick = function (event) {
            var modal = document.getElementById('editModal');
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>