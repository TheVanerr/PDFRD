# APK Oluşturma Scripti - PDF Okuyucu
# Kullanım: .\build-apk.ps1

param(
    [switch]$Release
)

$ProjectPath = "c:\Users\fatih.gural\Desktop\PDFRD"

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "   PDF Okuyucu APK Oluşturucu" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Proje dizinine git
Set-Location $ProjectPath

# JDK kontrolü
Write-Host "JDK kontrolü yapılıyor..." -ForegroundColor Yellow
try {
    $javaVersion = java -version 2>&1 | Select-String "version" | Select-Object -First 1
    Write-Host "✅ JDK bulundu: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ JDK bulunamadı! Lütfen JDK 17 kurun: https://adoptium.net/" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Gradle wrapper kontrolü
if (-not (Test-Path ".\gradlew.bat")) {
    Write-Host "⚙️  Gradle wrapper oluşturuluyor..." -ForegroundColor Yellow
    try {
        gradle wrapper --gradle-version 8.0
        Write-Host "✅ Gradle wrapper oluşturuldu" -ForegroundColor Green
    } catch {
        Write-Host "❌ Gradle wrapper oluşturulamadı. 'gradle' komutunun yüklü olduğundan emin olun." -ForegroundColor Red
        exit 1
    }
}

Write-Host ""

# Temizlik
Write-Host "🧹 Önceki build temizleniyor..." -ForegroundColor Yellow
.\gradlew clean | Out-Null

Write-Host ""

# APK oluştur
if ($Release) {
    Write-Host "📦 Release APK oluşturuluyor..." -ForegroundColor Yellow
    .\gradlew assembleRelease
    $ApkPath = "app\build\outputs\apk\release\app-release-unsigned.apk"
} else {
    Write-Host "📦 Debug APK oluşturuluyor..." -ForegroundColor Yellow
    .\gradlew assembleDebug
    $ApkPath = "app\build\outputs\apk\debug\app-debug.apk"
}

Write-Host ""

# Sonuç
if ($LASTEXITCODE -eq 0) {
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host "   ✅ APK BAŞARIYLA OLUŞTURULDU!" -ForegroundColor Green
    Write-Host "=====================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "APK Konumu:" -ForegroundColor Cyan
    Write-Host "$ProjectPath\$ApkPath" -ForegroundColor White
    Write-Host ""
    
    # Dosya boyutu
    if (Test-Path $ApkPath) {
        $FileSize = [math]::Round((Get-Item $ApkPath).Length / 1MB, 2)
        Write-Host "Dosya Boyutu: $FileSize MB" -ForegroundColor Cyan
        Write-Host ""
        
        # Dosya gezgininde aç
        Write-Host "📂 Dosya konumunu açmak için Enter'a basın..." -ForegroundColor Yellow
        Read-Host
        explorer.exe "/select,$ProjectPath\$ApkPath"
    }
} else {
    Write-Host "=====================================" -ForegroundColor Red
    Write-Host "   ❌ APK OLUŞTURULAMADI!" -ForegroundColor Red
    Write-Host "=====================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Yukarıdaki hata mesajlarını kontrol edin." -ForegroundColor Yellow
    exit 1
}
