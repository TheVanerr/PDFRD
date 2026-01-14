# PDF Okuyucu - Huawei T9 Tablet

Huawei T9 tablet için geliştirilmiş modern ve kullanışlı bir PDF okuyucu uygulaması.

## Özellikler

- ✅ PDF dosyalarını açma ve görüntüleme
- ✅ Sayfa kaydırma (yukarı/aşağı)
- ✅ Yakınlaştırma ve uzaklaştırma (pinch-to-zoom)
- ✅ Sayfa navigasyonu ve sayfa bilgisi
- ✅ Tam Türkçe arayüz
- ✅ Basit ve kullanıcı dostu tasarım
- ✅ Dosya yöneticisinden PDF açma desteği
- ✅ Android 7.0 ve üzeri tüm cihazlarla uyumlu

## Gereksinimler

### Yöntem 1: Sadece Komut Satırı (Önerilen - Android Studio Gerektirmez)
- JDK 17 veya üzeri ([İndir](https://adoptium.net/))
- Android Command Line Tools ([İndir](https://developer.android.com/studio#command-tools))
- Huawei T9 Tablet

### Yöntem 2: Online Derleyiciler (En Kolay)
- Hiçbir kurulum gerektirmez
- Web tarayıcısı yeterli

### Yöntem 3: Android Studio (İsteğe Bağlı)
- Android Studio (Arctic Fox veya üzeri)
- JDK 8 veya üzeri
- Huawei T9 Tablet

## Kurulum ve Derleme

## 🚀 YÖNTEM 1: Komut Satırı ile APK Oluşturma (Android Studio GEREKMEz)

Bu yöntem en hızlı ve pratik yöntemdir.

### Adım 1: JDK Kurulumu

1. [Adoptium JDK 17](https://adoptium.net/) indirin ve kurun
2. Kurulum sonrası PowerShell'de test edin:
```powershell
java -version
```

### Adım 2: Android Command Line Tools Kurulumu

1. [Android Command Line Tools](https://developer.android.com/studio#command-tools) indirin
2. Şu konuma çıkartın: `C:\Android\cmdline-tools\latest\`
3. PowerShell'de environment variable ayarlayın:

```powershell
# ANDROID_HOME ayarla
[System.Environment]::SetEnvironmentVariable("ANDROID_HOME", "C:\Android", "User")

# PATH'e ekle
$path = [System.Environment]::GetEnvironmentVariable("PATH", "User")
$newPath = "$path;C:\Android\cmdline-tools\latest\bin;C:\Android\platform-tools"
[System.Environment]::SetEnvironmentVariable("PATH", $newPath, "User")

# PowerShell'i yeniden başlatın
```

4. SDK bileşenlerini yükleyin:
```powershell
sdkmanager "platform-tools" "platforms;android-34" "build-tools;34.0.0"
```

### Adım 3: Gradle Wrapper Oluştur

```powershell
cd "c:\Users\fatih.gural\Desktop\PDFRD"

# Gradle wrapper indir (internet gerekli)
gradle wrapper --gradle-version 8.0
```

### Adım 4: APK Oluştur

```powershell
cd "c:\Users\fatih.gural\Desktop\PDFRD"

# Debug APK oluştur (test için)
.\gradlew assembleDebug

# APK konumu: app\build\outputs\apk\debug\app-debug.apk
```

APK hazır! Tabletinize kopyalayıp yükleyin.

---

## 🌐 YÖNTEM 2: Online Derleyici Kullanma (EN KOLAY)

Hiçbir kurulum yapmadan online derleyiciler kullanabilirsiniz:

### A) GitHub Actions ile (Ücretsiz)

1. Projeyi GitHub'a yükleyin
2. `.github/workflows/build.yml` dosyası oluşturun (aşağıda hazır)
3. GitHub otomatik olarak APK derler
4. "Actions" sekmesinden APK'yı indirin

### B) Online Android IDE'ler

- **AIDE** - Android cihazda bile derleme yapabilirsiniz
- **Replit** - Tarayıcıda kod yazıp derleyin
- **CodeAnywhere** - Bulut tabanlı IDE

---

## 🏢 YÖNTEM 3: Visual Studio Code ile (Hafif Alternatif)

Android Studio çok ağırsa VS Code kullanabilirsiniz:

1. [VS Code](https://code.visualstudio.com/) indirin
2. Şu eklentileri yükleyin:
   - Android Dev Tools
   - Gradle for Java
3. Yukarıdaki komut satırı adımlarını takip edin
4. VS Code terminalinde `.\gradlew assembleDebug` çalıştırın

---

## 📦 Hazır APK Oluşturma Scripti

Kolaylık için otomatik script:

```powershell
# build-apk.ps1
cd "c:\Users\fatih.gural\Desktop\PDFRD"

Write-Host "APK olusturuluyor..." -ForegroundColor Green

# Gradle wrapper yoksa oluştur
if (-not (Test-Path ".\gradlew.bat")) {
    Write-Host "Gradle wrapper olusturuluyor..."
    gradle wrapper --gradle-version 8.0
}

# APK oluştur
.\gradlew clean assembleDebug

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ APK basariyla olusturuldu!" -ForegroundColor Green
    Write-Host "Konum: app\build\outputs\apk\debug\app-debug.apk" -ForegroundColor Cyan
} else {
    Write-Host "❌ Hata olustu!" -ForegroundColor Red
}
```

Kullanımı:
```powershell
.\build-apk.ps1
```

### 5. Huawei T9'a Yükleme

#### USB ile:

1. Huawei T9'da Geliştirici Seçenekleri'ni etkinleştirin:
   - Ayarlar > Sistem > Tablet Hakkında > Yapı Numarası'na 7 kez tıklayın
   
2. USB Hata Ayıklama'yı etkinleştirin:
   - Ayarlar > Sistem > Geliştirici Seçenekleri > USB Hata Ayıklama

3. Tableti USB ile bilgisayara bağlayın

4. PowerShell'de:
```powershell
.\gradlew installDebug
```

#### APK Dosyası İle:

1. APK dosyasını tablet'e kopyalayın
2. Tablet'te dosya yöneticisini açın
3. APK dosyasına tıklayın ve "Yükle" seçeneğini seçin
4. "Bilinmeyen Kaynaklardan Yükleme" iznini verin

## Kullanım

1. Uygulamayı açın
2. Sağ üst köşedeki arama simgesine tıklayarak PDF dosyası seçin
3. PDF görüntülenir
4. Parmak hareketleriyle:
   - Yukarı/aşağı kaydırarak sayfalar arası geçiş yapın
   - İki parmakla sıkıştırarak yakınlaştırın/uzaklaştırın
   - Çift tıklayarak hızlı yakınlaştırma yapın

## Kullanılan Kütüphaneler

- **AndroidPdfViewer (barteksc)**: PDF görüntüleme kütüphanesi
- **AndroidX Libraries**: Modern Android bileşenleri
- **Material Design Components**: Google Material tasarım bileşenleri

## Sorun Giderme

### Gradle Senkronizasyon Hatası

Maven repository erişim sorunu yaşanıyorsa:

1. `settings.gradle` dosyasına ekleyin:
```gradle
dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://jitpack.io' }
    }
}
```

### Depolama İzni Sorunu

Android 11+ için "Tüm dosyalara erişim" iznini manuel olarak verin:
- Ayarlar > Uygulamalar > PDF Okuyucu > İzinler > Dosyalar ve Medya

## Geliştirici Notları

### Proje Yapısı

```
PDFRD/
├── app/
│   ├── src/
│   │   └── main/
│   │       ├── java/com/huawei/pdfreader/
│   │       │   └── MainActivity.java
│   │       ├── res/
│   │       │   ├── layout/
│   │       │   │   └── activity_main.xml
│   │       │   ├── menu/
│   │       │   │   └── menu_main.xml
│   │       │   └── values/
│   │       │       ├── strings.xml
│   │       │       └── colors.xml
│   │       └── AndroidManifest.xml
│   └── build.gradle
├── build.gradle
├── settings.gradle
├── gradle.properties
└── README.md
```

### Özelleştirme

Renkleri değiştirmek için `res/values/colors.xml` dosyasını düzenleyin.
Metinleri değiştirmek için `res/values/strings.xml` dosyasını düzenleyin.

## Lisans

Bu proje kişisel kullanım için geliştirilmiştir.

## İletişim

Sorularınız için: fatih.gural@example.com

## Versiyon Geçmişi

### v1.0 (Ocak 2026)
- İlk sürüm
- Temel PDF okuma özellikleri
- Türkçe arayüz
- Huawei T9 optimizasyonu
