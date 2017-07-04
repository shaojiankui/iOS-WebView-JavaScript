package org.skyfox.android_webview_javascript;

import android.os.Build;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.webkit.JavascriptInterface;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.Toast;

import org.json.JSONObject;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        WebView webview = (WebView) findViewById(R.id.webview);
        WebSettings webSettings = webview.getSettings();
        webSettings.setJavaScriptEnabled(true);
        webview.setWebChromeClient(new WebChromeClient()); //webview只是一个承载体，各种内容的渲染需要使用webviewChromClient去实现，所以set一个默认的基类WebChromeClient就行
        webview.addJavascriptInterface(this,"Native");  //注入Native对象到webview window中

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            WebView.setWebContentsDebuggingEnabled(true);
        }

      webview.loadUrl("file:///android_asset/JSWebView.html");


//        webview.loadUrl("http://dev.skyfox.org/JSWebView.html");
//        webView.loadUrl("javascript:alert(Native.alert())");
    }
    @JavascriptInterface
    public void alert(String param){
        Log.i("A",param.toString());


    }
}
