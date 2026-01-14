# Hızlı Kurulum Scripti - PDF Okuyucu
# Bu script gerekli araçları yüklemenize yardımcı olur

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "   PDF Okuyucu - Hızlı Kurulum" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Admin kontrolü
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "⚠️  Bu script için yönetici hakları gerekebilir." -ForegroundColor Yellow
    Write-Host ""
}

# JDK Kontrolü
Write-Host "1️⃣  JDK Kontrolü" -ForegroundColor Cyan
Write-Host "-----------------------------------" -ForegroundColor Gray
try {
    $javaVersion = java -version 2>&1 | Select-String "version" | Select-Object -First 1
    Write-Host "✅ JDK zaten yüklü: $javaVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ JDK bulunamadı!" -ForegroundColor Red
    Write-Host ""
    Write-Host "JDK indirmek için tarayıcı açılıyor..." -ForegroundColor Yellow
    Start-Process "https://adoptium.net/temurin/releases/?version=17"
    Write-Host ""
    Write-Host "JDK'yı indirip kurduktan sonra bu scripti tekrar çalıştırın." -ForegroundColor Yellow
    Read-Host "Devam etmek için Enter'a basın"
    exit
}

Write-Host ""

# Gradle Kontrolü
Write-Host "2️⃣  Gradle Kontrolü" -ForegroundColor Cyan
Write-Host "-----------------------------------" -ForegroundColor Gray
try {
    $gradleVersion = gradle -v 2>&1 | Select-String "Gradle" | Select-Object -First 1
    Write-Host "✅ Gradle zaten yüklü: $gradleVersion" -ForegroundColor Green
} catch {
    Write-Host "⚠️  Gradle bulunamadı (opsiyonel)" -ForegroundColor Yellow
    Write-Host "Gradle wrapper kullanılacak, sorun değil." -ForegroundColor Gray
}

Write-Host ""

# Android SDK Kontrolü (Opsiyonel)
Write-Host "3️⃣  Android SDK Kontrolü (Opsiyonel)" -ForegroundColor Cyan
Write-Host "-----------------------------------" -ForegroundColor Gray
if ($env:ANDROID_HOME) {
    Write-Host "✅ ANDROID_HOME ayarlanmış: $env:ANDROID_HOME" -ForegroundColor Green
} else {
    Write-Host "⚠️  ANDROID_HOME ayarlanmamış" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Android Command Line Tools kurmak ister misiniz? (Y/N)" -ForegroundColor Yellow
    $response = Read-Host
    
    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host ""
        Write-Host "Android Command Line Tools indirme sayfası açılıyor..." -ForegroundColor Yellow
        Start-Process "https://developer.android.com/studio#command-tools"
        Write-Host ""
        Write-Host "İndirme Talimatları:" -ForegroundColor Cyan
        Write-Host "1. commandlinetools-win-*.zip dosyasını indirin" -ForegroundColor White
        Write-Host "2. C:\Android\cmdline-tools\latest\ konumuna çıkartın" -ForegroundColor White
        Write-Host "3. Bu scripti tekrar çalıştırın" -ForegroundColor White
    }
}

Write-Host ""
Write-Host ""

# Özet
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "   KURULUM DURUMU" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

$allOk = $true

if (Get-Command java -ErrorAction SilentlyContinue) {
    Write-Host "✅ JDK: Hazır" -ForegroundColor Green
} else {
    Write-Host "❌ JDK: Eksik" -ForegroundColor Red
    $allOk = $false
}

Write-Host ""

if ($allOk) {
    Write-Host "🎉 Tüm gereksinimler hazır!" -ForegroundColor Green
    Write-Host ""
    Write-Host "APK oluşturmak için şu komutu çalıştırın:" -ForegroundColor Cyan
    Write-Host ".\build-apk.ps1" -ForegroundColor White
} else {
    Write-Host "⚠️  Bazı gereksinimler eksik. Yukarıdaki talimatlara göre kurulumları tamamlayın." -ForegroundColor Yellow
}

Write-Host ""
Read-Host "Çıkmak için Enter'a basın"
