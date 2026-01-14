# APK'yı Tablet'e Yükleme Kılavuzu

Bu dosya, oluşturduğunuz APK'yı Huawei T9 tabletinize nasıl yükleyeceğinizi anlatır.

## Yöntem 1: USB Kablo ile (Önerilen)

### Ön Hazırlık (Tek Seferlik)

1. **Geliştirici Seçeneklerini Etkinleştirin:**
   - Tablet'te: Ayarlar > Sistem > Tablet Hakkında
   - "Yapı Numarası"na **7 kez** hızlıca tıklayın
   - "Artık geliştiriciysiniz!" mesajı görünecek

2. **USB Hata Ayıklamayı Açın:**
   - Ayarlar > Sistem > Geliştirici Seçenekleri
   - "USB Hata Ayıklama" seçeneğini açın

### APK Yükleme

1. Tablet'i USB ile bilgisayara bağlayın
2. Bilgisayarda PowerShell açın:

```powershell
# Android Platform Tools gerekli (bir kere indirilir)
# İndir: https://developer.android.com/studio/releases/platform-tools

cd "C:\platform-tools"  # Platform tools konumunuz

# Cihazın bağlı olduğunu kontrol edin
.\adb devices

# APK'yı yükleyin
.\adb install "c:\Users\fatih.gural\Desktop\PDFRD\app\build\outputs\apk\debug\app-debug.apk"
```

3. Kurulum tamamlandı! Tablet'te uygulamayı açın.

---

## Yöntem 2: E-posta ile (Kolay)

1. APK dosyasını kendinize e-posta ile gönderin
2. Tablet'te e-postayı açın
3. APK'yı indirin ve tıklayın
4. "Bilinmeyen Kaynaklardan Yükleme" iznini verin
5. Yükle'ye tıklayın

---

## Yöntem 3: USB Bellek / SD Kart ile

1. APK'yı USB belleğe veya SD karta kopyalayın
2. USB belleği tablet'e takın
3. Dosya yöneticisini açın
4. APK dosyasını bulun ve tıklayın
5. "Bilinmeyen Kaynaklardan Yükleme" iznini verin
6. Yükle'ye tıklayın

---

## Yöntem 4: Google Drive / OneDrive ile

1. APK'yı bulut sürücünüze yükleyin
2. Tablet'te bulut uygulamasını açın
3. APK'yı indirin
4. İndirilenler klasöründen APK'ya tıklayın
5. Yükle'ye tıklayın

---

## Yöntem 5: Kablosuz ADB (USB Kablo Olmadan)

### İlk Kurulum (USB Kablo ile)

```powershell
# USB ile bağlıyken
.\adb tcpip 5555
```

### Kablosuz Bağlantı

```powershell
# Tabletin IP adresini öğrenin (Ayarlar > WLAN > Bağlı ağ detayları)
# Örnek IP: 192.168.1.100

.\adb connect 192.168.1.100:5555
.\adb install "c:\Users\fatih.gural\Desktop\PDFRD\app\build\outputs\apk\debug\app-debug.apk"
```

---

## Sorun Giderme

### "Uygulama Yüklenmedi" Hatası

**Çözüm 1:** Eski sürümü kaldırın
- Ayarlar > Uygulamalar > PDF Okuyucu > Kaldır

**Çözüm 2:** Bilinmeyen kaynaklara izin verin
- Ayarlar > Güvenlik ve Gizlilik > Bilinmeyen Kaynaklar > İzin Ver

### "Parse Hatası" Alıyorum

APK bozuk olabilir. Yeniden derleyin:
```powershell
.\gradlew clean assembleDebug
```

### ADB Cihazı Görmüyor

1. USB kablosunu değiştirin
2. USB Hata Ayıklamayı kapatıp açın
3. Bilgisayarda USB sürücülerini güncelleyin
4. Tablet'i yeniden başlatın

---

## Otomatik Yükleme Scripti

Kolaylık için otomatik script:

```powershell
# install-to-tablet.ps1
$ApkPath = "c:\Users\fatih.gural\Desktop\PDFRD\app\build\outputs\apk\debug\app-debug.apk"
$AdbPath = "C:\platform-tools\adb.exe"  # Kendi yolunuzu girin

Write-Host "Tablet'e yükleniyor..." -ForegroundColor Yellow

# Cihaz kontrolü
& $AdbPath devices

# Yükle
& $AdbPath install -r $ApkPath

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ APK başarıyla yüklendi!" -ForegroundColor Green
} else {
    Write-Host "❌ Yükleme başarısız!" -ForegroundColor Red
}
```

---

## APK İmzalama (Opsiyonel - Play Store için)

Release APK'yı imzalamak için:

```powershell
# Keystore oluştur (bir kere)
keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias

# APK imzala
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.jks app-release-unsigned.apk my-key-alias

# Align et
zipalign -v 4 app-release-unsigned.apk app-release.apk
```

---

## Güncelleme Yükleme

Yeni sürüm yüklerken:

1. Eski sürümü **kaldırmayın** (veriler korunur)
2. Yeni APK'yı yükleyin
3. "Güncelle" butonuna tıklayın

✅ Uygulama otomatik güncellenecektir!
