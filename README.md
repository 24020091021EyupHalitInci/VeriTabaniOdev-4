# 🍽️ Çoklu Dil ve VTYS Entegrasyonlu Yemek Tarifi Portalı

Bu repo; aynı iş mantığı ve arayüz tasarımına sahip bir yemek tarifi uygulamasının, üç farklı programlama dili ve üç farklı veritabanı yönetim sistemi (VTYS) kullanılarak geliştirilmiş versiyonlarını içermektedir.
<img width="2553" height="1327" alt="Ekran görüntüsü 2026-05-07 165204" src="https://github.com/user-attachments/assets/b0f8f589-ce8f-4f41-b866-89002caf41ca" />


## 🚀 Proje Hakkında
Bu çalışma, farklı yazılım ekosistemlerinin veritabanı bağlantı mimarilerini ve CRUD (Create, Read, Update, Delete) operasyonlarını karşılaştırmalı olarak deneyimlemek amacıyla hazırlanmıştır. Her üç platformda da **modern ve şık bir kullanıcı arayüzü** (Glassmorphism & Gradient Design) kullanılmıştır.

### 🛠️ Kullanılan Teknolojiler ve Eşleşmeler

| Klasör Adı | Programlama Dili | Veritabanı Yönetim Sistemi |
| :--- | :--- | :--- |
| **yemektarif-asp** | ASP.NET C# (Web Forms) | Microsoft SQL Server (MSSQL) |
| **yemektarif-php** | PHP 8.x | MySQL |
| **yemekTarif-jsp** | Java (JSP / Maven) | PostgreSQL |

---

## 📂 Klasör Yapısı
- **`yemektarif-asp/`**: ASP.NET Web Forms dosyaları ve Code-Behind (C#) mantığı.
- **`yemektarif-php/`**: PHP scriptleri ve PDO veritabanı bağlantı katmanı.
- **`yemekTarif-jsp/`**: Maven tabanlı Java Server Pages (JSP) projesi.

---

## 🏗️ Veri Tabanı Şeması ve Kurulum
Projelerde harici bir SQL script dosyası yer almamaktadır. Uygulamaların çalışması için ilgili VTYS sunucularında (MSSQL, MySQL, PostgreSQL) aşağıdaki yapıya sahip bir **Tarifler** tablosu manuel olarak oluşturulmalıdır:

| Sütun Adı | Veri Tipi | Özellikler |
| :--- | :--- | :--- |
| **id** | INT / SERIAL | Primary Key, Identity / Auto Increment |
| **baslik** | NVARCHAR / VARCHAR(255) | Not Null |
| **detay** | TEXT / NVARCHAR(MAX) | Not Null |
| **fotograf_url** | VARCHAR(255) | Nullable |
| **olusturulma_tarihi** | DATETIME / TIMESTAMP | Default: Current Timestamp |

---

## 📱 Uygulama Özellikleri
1.  **Tarif Listeleme:** Veritabanındaki tüm yemeklerin dinamik kart yapısıyla (Bootstrap Grid) ana ekranda gösterilmesi.
2.  **Tarif Detay:** Seçilen tarifin içeriğinin ve görselinin tam sayfa olarak incelenmesi.
3.  **Yönetim Paneli (CRUD):** * **Ekleme:** Yeni tariflerin başlık, detay ve görsel linkiyle sisteme kaydedilmesi.
    * **Güncelleme:** Mevcut tariflerin Modal (Popup) üzerinden düzenlenmesi.
    * **Silme:** Gereksiz tariflerin veritabanından güvenli bir şekilde kaldırılması.

---

## ⚙️ Çalıştırma Notları
* **ASP.NET:** IIS Express üzerinden `Default.aspx` sayfasını çalıştırın.
* **PHP:** Apache sunucusu (XAMPP/WampServer) üzerinden `index.php`'yi başlatın.
* **JSP:** Apache Tomcat sunucusu üzerinden Maven yapılandırmasını kullanarak projeyi deploy edin.

**Not:** Veritabanı bağlantısı için kodlardaki `Connection String` veya `Database Configuration` alanlarını kendi yerel sunucu bilgilerinizle (User, Password, Host) güncellemeyi unutmayın.
