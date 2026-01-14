package com.huawei.pdfreader;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.provider.Settings;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.github.barteksc.pdfviewer.PDFView;
import com.github.barteksc.pdfviewer.listener.OnLoadCompleteListener;
import com.github.barteksc.pdfviewer.listener.OnPageChangeListener;
import com.github.barteksc.pdfviewer.listener.OnPageErrorListener;
import com.github.barteksc.pdfviewer.scroll.DefaultScrollHandle;

import java.io.File;

public class MainActivity extends AppCompatActivity implements OnPageChangeListener, OnLoadCompleteListener, OnPageErrorListener {

    private static final int REQUEST_CODE_PICK_PDF = 1001;
    private static final int REQUEST_CODE_STORAGE_PERMISSION = 1002;
    
    private PDFView pdfView;
    private TextView tvPageInfo;
    private Uri pdfUri;
    private int currentPage = 0;
    private int totalPages = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Toolbar kurulumu
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        if (getSupportActionBar() != null) {
            getSupportActionBar().setTitle(R.string.app_name);
        }

        pdfView = findViewById(R.id.pdfView);
        tvPageInfo = findViewById(R.id.tvPageInfo);

        // İzin kontrolü
        checkStoragePermission();

        // Eğer uygulama bir PDF dosyası ile açıldıysa
        Intent intent = getIntent();
        if (Intent.ACTION_VIEW.equals(intent.getAction()) && intent.getData() != null) {
            pdfUri = intent.getData();
            displayPdf(pdfUri);
        }
    }

    private void checkStoragePermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            // Android 11 ve üzeri
            if (!Environment.isExternalStorageManager()) {
                Intent intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                Uri uri = Uri.fromParts("package", getPackageName(), null);
                intent.setData(uri);
                startActivity(intent);
            }
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            // Android 6.0 - 10
            if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) 
                != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this,
                    new String[]{Manifest.permission.READ_EXTERNAL_STORAGE,
                                Manifest.permission.WRITE_EXTERNAL_STORAGE},
                    REQUEST_CODE_STORAGE_PERMISSION);
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == REQUEST_CODE_STORAGE_PERMISSION) {
            if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(this, R.string.permission_granted, Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(this, R.string.permission_denied, Toast.LENGTH_LONG).show();
            }
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        int id = item.getItemId();
        
        if (id == R.id.action_open_file) {
            openFilePicker();
            return true;
        } else if (id == R.id.action_about) {
            Toast.makeText(this, R.string.about_message, Toast.LENGTH_LONG).show();
            return true;
        }
        
        return super.onOptionsItemSelected(item);
    }

    private void openFilePicker() {
        Intent intent = new Intent(Intent.ACTION_OPEN_DOCUMENT);
        intent.addCategory(Intent.CATEGORY_OPENABLE);
        intent.setType("application/pdf");
        startActivityForResult(intent, REQUEST_CODE_PICK_PDF);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        
        if (requestCode == REQUEST_CODE_PICK_PDF && resultCode == RESULT_OK) {
            if (data != null && data.getData() != null) {
                pdfUri = data.getData();
                displayPdf(pdfUri);
            }
        }
    }

    private void displayPdf(Uri uri) {
        if (uri == null) {
            Toast.makeText(this, R.string.error_no_file, Toast.LENGTH_SHORT).show();
            return;
        }

        try {
            pdfView.fromUri(uri)
                    .defaultPage(0)
                    .enableSwipe(true)
                    .swipeHorizontal(false)
                    .enableDoubletap(true)
                    .enableAnnotationRendering(true)
                    .scrollHandle(new DefaultScrollHandle(this))
                    .spacing(10)
                    .onLoad(this)
                    .onPageChange(this)
                    .onPageError(this)
                    .load();
        } catch (Exception e) {
            Toast.makeText(this, R.string.error_loading_pdf + ": " + e.getMessage(), 
                          Toast.LENGTH_LONG).show();
            e.printStackTrace();
        }
    }

    @Override
    public void onPageChanged(int page, int pageCount) {
        currentPage = page;
        totalPages = pageCount;
        updatePageInfo();
    }

    @Override
    public void loadComplete(int nbPages) {
        totalPages = nbPages;
        updatePageInfo();
        Toast.makeText(this, getString(R.string.pdf_loaded) + " " + nbPages + " " + 
                      getString(R.string.pages), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void onPageError(int page, Throwable t) {
        Toast.makeText(this, R.string.error_page + " " + page + ": " + t.getMessage(), 
                      Toast.LENGTH_SHORT).show();
    }

    private void updatePageInfo() {
        if (totalPages > 0) {
            String pageInfo = getString(R.string.page) + " " + (currentPage + 1) + " / " + totalPages;
            tvPageInfo.setText(pageInfo);
        } else {
            tvPageInfo.setText(R.string.no_pdf_loaded);
        }
    }
}
