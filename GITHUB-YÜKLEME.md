# GitHub ile APK Oluşturma Kılavuzu
# Hiçbir Kurulum Gerektirmez! 🎉

Bu yöntemle bilgisayarınıza hiçbir şey kurmadan APK oluşturabilirsiniz.

## 📋 Adımlar

### 1. GitHub Hesabı Oluşturun (Ücretsiz)

1. https://github.com adresine gidin
2. "Sign up" ile ücretsiz hesap oluşturun
3. E-postanızı doğrulayın

### 2. Yeni Repository (Proje) Oluşturun

1. GitHub'da sağ üstteki "+" simgesine tıklayın
2. "New repository" seçin
3. Repository adı: `pdf-reader-huawei` (veya istediğiniz ad)
4. "Public" veya "Private" seçin (ikisi de çalışır)
5. "Create repository" tıklayın

### 3. Projeyi GitHub'a Yükleyin

#### Yöntem A: GitHub Web Arayüzü ile (En Kolay)

1. Repository sayfasında "uploading an existing file" linkine tıklayın
2. Bu klasördeki **TÜM** dosyaları sürükleyip bırakın:
   ```
   c:\Users\fatih.gural\Desktop\PDFRD
   ```
   
   Önemli: Şu dosyaları mutlaka yükleyin:
   - ✅ .github/workflows/build.yml (otomatik derleme için!)
   - ✅ app/ klasörü (tüm içeriğiyle)
   - ✅ build.gradle
   - ✅ settings.gradle
   - ✅ gradle.properties
   - ✅ README.md

3. "Commit changes" tıklayın

#### Yöntem B: Git ile (Daha Hızlı)

PowerShell'de:

```powershell
cd "c:\Users\fatih.gural\Desktop\PDFRD"

# Git yoksa indir: https://git-scm.com/download/win
# Git kurduktan sonra PowerShell'i yeniden başlat

git init
git add .
git commit -m "İlk commit - PDF Reader uygulaması"
git branch -M main
git remote add origin https://github.com/KULLANICI_ADINIZ/pdf-reader-huawei.git
git push -u origin main
```

**Not:** `KULLANICI_ADINIZ` kısmını kendi GitHub kullanıcı adınızla değiştirin!

### 4. APK'nın Oluşmasını Bekleyin (Otomatik!)

1. Repository sayfanızda üstteki "Actions" sekmesine tıklayın
2. İlk workflow'un çalıştığını göreceksiniz (sarı nokta 🟡)
3. 3-5 dakika bekleyin (yeşil onay ✅ işareti çıkana kadar)
4. Tamamlandığında workflow'a tıklayın
5. Aşağı kaydırın, "Artifacts" bölümünde APK'ları göreceksiniz:
   - 📦 **pdf-reader-debug.apk** (test için)
   - 📦 **pdf-reader-release.apk** (son sürüm)

### 5. APK'yı İndirin

1. İstediğiniz APK'ya tıklayın (debug önerilir)
2. ZIP dosyası indirilir
3. ZIP'i açın, içinden APK'yı çıkarın
4. APK hazır! 🎉

---

## 🔄 Güncelleme Yapmak İsterseniz

Kod değişikliği yaptığınızda:

### Web Arayüzünden:

1. GitHub'da değiştirmek istediğiniz dosyaya gidin
2. Kalem simgesine (Edit) tıklayın
3. Değişikliği yapın
4. "Commit changes" tıklayın
5. **Otomatik olarak yeni APK oluşturulur!**

### PowerShell'den:

```powershell
cd "c:\Users\fatih.gural\Desktop\PDFRD"

# Değişiklikleri yükle
git add .
git commit -m "Değişiklik açıklaması"
git push

# GitHub otomatik olarak yeni APK derler!
```

---

## 🎯 İpuçları

### Her Dosya Yüklenmesinde APK Oluşturmasın İstemiyorsanız

`.github/workflows/build.yml` dosyasını düzenleyin, sadece manuel tetikleme bırakın:

```yaml
on:
  workflow_dispatch:  # Sadece bu satır kalsın
```

Bu durumda APK oluşturmak için:
1. Actions sekmesine gidin
2. "Android APK Builder" workflow'unu seçin
3. "Run workflow" butonuna tıklayın

### Private Repository Kullanın

Kodunuzun gizli kalmasını istiyorsanız repository'yi "Private" yapın.
GitHub Actions ücretsiz kullanımlarda bile çalışır!

---

## 📱 APK'yı Tablet'e Yükleme

APK'yı indirdikten sonra:

1. **E-posta ile:** APK'yı kendinize e-posta ile gönderin, tablet'te açın
2. **Google Drive:** APK'yı Drive'a yükleyin, tablet'ten indirin
3. **WhatsApp:** Kendinize gönderin, tablet'te indirin
4. **USB Kablo:** Bilgisayardan tablet'e kopyalayın

Tablet'te APK'ya tıklayınca:
- "Bilinmeyen Kaynaklardan Yükleme" iznini verin
- "Yükle" butonuna tıklayın
- Hazır! ✅

---

## ❓ Sorun Giderme

### "Actions" Sekmesini Göremiyorum

Repository ayarlarından Actions'ı etkinleştirin:
- Settings > Actions > General > Allow all actions

### Build Başarısız Oluyor (Kırmızı ❌)

1. Workflow loglarını kontrol edin
2. `.github/workflows/build.yml` dosyasının doğru yüklendiğinden emin olun
3. `gradlew` dosyasının yüklendiğinden emin olun

### Git Komutları Çalışmıyor

1. Git'i indirin: https://git-scm.com/download/win
2. Kurulum sırasında tüm varsayılan ayarları kabul edin
3. PowerShell'i yeniden başlatın

---

## 🎊 Tamamdır!

Artık:
- ✅ Hiçbir şey kurmadınız
- ✅ GitHub sizin için APK oluşturuyor
- ✅ Her güncellemede otomatik yeni APK
- ✅ Ücretsiz ve sınırsız!

**Önemli:** İlk defa yapıyorsanız, `.github/workflows/build.yml` dosyasını mutlaka yüklemeyi unutmayın!
