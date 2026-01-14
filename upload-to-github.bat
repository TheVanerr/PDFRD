@echo off
echo =========================================
echo    PDF Reader - GitHub Upload Helper
echo =========================================
echo.

REM Proje dizinine git
cd /d "c:\Users\fatih.gural\Desktop\PDFRD"

echo Git kontrolu yapiliyor...
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo [HATA] Git bulunamadi!
    echo.
    echo Git yuklemek icin: https://git-scm.com/download/win
    echo Git kurduktan sonra bilgisayari yeniden baslatin.
    echo.
    pause
    exit /b 1
)

echo Git bulundu!
echo.

REM Git repository'si var mı kontrol et
if not exist ".git" (
    echo Yeni Git repository'si olusturuluyor...
    git init
    git branch -M main
    echo.
)

echo GitHub kullanici adinizi girin:
set /p GITHUB_USER="> "
echo.

echo Repository adinizi girin (ornek: pdf-reader-huawei):
set /p REPO_NAME="> "
echo.

echo Tum dosyalar ekleniyor...
git add .
echo.

echo Commit mesaji (Enter = varsayilan):
set /p COMMIT_MSG="> "
if "%COMMIT_MSG%"=="" set COMMIT_MSG=PDF Reader uygulamasi eklendi

echo.
echo Commit yapiliyor...
git commit -m "%COMMIT_MSG%"
echo.

REM Remote varsa sil ve yeniden ekle
git remote remove origin >nul 2>nul

echo Remote ekleniyor...
git remote add origin https://github.com/%GITHUB_USER%/%REPO_NAME%.git
echo.

echo GitHub'a gonderiliyor...
echo.
echo [NOT] GitHub kullanici adi ve token isteyecek.
echo Token olusturmak icin: https://github.com/settings/tokens
echo.
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo =========================================
    echo    BASARILI! GitHub'a yuklendi!
    echo =========================================
    echo.
    echo Repository URL:
    echo https://github.com/%GITHUB_USER%/%REPO_NAME%
    echo.
    echo Actions sayfasi:
    echo https://github.com/%GITHUB_USER%/%REPO_NAME%/actions
    echo.
    echo Sirasiyla:
    echo 1. Actions linkini acin
    echo 2. Workflow'un tamamlanmasini bekleyin (3-5 dakika)
    echo 3. APK'yi indirin!
    echo.
    
    echo Repository'yi acmak ister misiniz? (Y/N)
    set /p OPEN_BROWSER="> "
    if /i "%OPEN_BROWSER%"=="Y" (
        start https://github.com/%GITHUB_USER%/%REPO_NAME%
    )
) else (
    echo.
    echo [HATA] GitHub'a gonderilemedi!
    echo.
    echo Olasi sebepler:
    echo - Repository henuz olusturulmamis
    echo - Kullanici adi veya token yanlis
    echo - Internet baglantisi yok
    echo.
    echo Cozum:
    echo 1. GitHub'da repository'yi manuel olusturun
    echo 2. https://github.com/%GITHUB_USER%/%REPO_NAME%
    echo 3. Bu scripti tekrar calistirin
)

echo.
pause
