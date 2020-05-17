package com.mokshbhansali.wallty_app;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;

import android.annotation.TargetApi;
import android.app.WallpaperManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Bundle;
import android.os.StrictMode;
import android.util.DisplayMetrics;
import android.util.Log;
import android.widget.ProgressBar;
import android.widget.Toast;
import java.net.URL;
import java.io.IOException;
import java.net.MalformedURLException;
import android.content.Context;

public class MainActivity extends FlutterActivity {

   private static final String CHANNEL = "setMyImagesAsWallpaper";
    private ProgressBar progressBar;
    @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
    StrictMode.setThreadPolicy(policy);
    GeneratedPluginRegistrant.registerWith(flutterEngine);
    new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                    (call, result) -> {
                      if (call.method.equals("setAsLockScreen")) {
                        String param;
                        param = call.argument("text");
                        Log.e("error", "param");
                        boolean myResult= false;
                           myResult = setAsLockScreen(param);
                           if(myResult)
                           {
                               result.success(true);
                           }
                           else
                           {
                            // Toast.makeText(this,"Error!==>",Toast.LENGTH_SHORT).show();
                           }
                      }
                      else if(call.method.equals("setAsHomeScreen")){
                        String data;
                        data = call.argument("text");
                        Log.e("error","data");
                        boolean mydata =false;
                          mydata = setAsHomeScreen(data);
                          if(mydata)
                          {
                            result.success(true);
                          }
                          else
                          {
                            // Toast.makeText(this,"Error!==>",Toast.LENGTH_SHORT).show();
                          }
                      }
                      else {
                        result.notImplemented();
                      }
                    }
            );
  }
  private boolean setAsLockScreen(String url)  {

    try{
        WallpaperManager wm = WallpaperManager.getInstance(getApplicationContext());
        DisplayMetrics metrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metrics);
        int height = metrics.heightPixels;
        int width = metrics.widthPixels;
        URL imageUrl = new URL(url);
        Bitmap myBitMap = BitmapFactory.decodeStream(imageUrl.openConnection().getInputStream());
        Bitmap yourbitmap = Bitmap.createScaledBitmap(myBitMap, width, height, true);
        wm.setBitmap(yourbitmap, null, true, WallpaperManager.FLAG_LOCK);
      return true;
    }
    catch (IOException e){
      Toast.makeText(this,"Error!==>"+e.getMessage(),Toast.LENGTH_SHORT).show();
      return false;
    }

  }
  //setAs HomeScreen Method
  private boolean setAsHomeScreen(String url){
    try{
       WallpaperManager wm = WallpaperManager.getInstance(getApplicationContext());
        DisplayMetrics metrics = new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(metrics);
        int height = metrics.heightPixels;
        int width = metrics.widthPixels;
        URL imageUrl = new URL(url);
        Bitmap myBitMap = BitmapFactory.decodeStream(imageUrl.openConnection().getInputStream());
        Bitmap yourbitmap = Bitmap.createScaledBitmap(myBitMap, width, height, true);
        wm.setBitmap(yourbitmap, null, true, WallpaperManager.FLAG_SYSTEM);

      return true;
    }
    catch (IOException e){
      Toast.makeText(this,"Error!==>"+e.getMessage(),Toast.LENGTH_SHORT).show();
      return false;
    }
  }
}
