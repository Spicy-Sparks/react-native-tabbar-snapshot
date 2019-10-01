package com.marf.RNTabBarSnapshot;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.Application;
import android.content.ComponentName;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.os.Build;
import android.os.LocaleList;
import android.util.Base64;
import android.view.View;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableArray;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

public class RNTabBarSnapshotModule extends ReactContextBaseJavaModule {

  private int bottomTabsId = -1;

  public RNTabBarSnapshotModule(ReactApplicationContext reactContext, int bottomTabsId) {
    super(reactContext);
    this.bottomTabsId = bottomTabsId;
  }

  @Override
  public String getName() {
    return "RNTabBarSnapshot";
  }

  private String makeSnapShot() {

    View iv = (View) getReactApplicationContext().getCurrentActivity().getWindow().findViewById(bottomTabsId);
    Bitmap bitmap = Bitmap.createBitmap(
            iv.getWidth(),
            iv.getHeight(),
            Bitmap.Config.ARGB_8888);
    Canvas c = new Canvas(bitmap);
    iv.draw(c);

    ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
    bitmap.compress(Bitmap.CompressFormat.PNG, 100, byteArrayOutputStream);
    byte[] byteArray = byteArrayOutputStream .toByteArray();

    String encoded = Base64.encodeToString(byteArray, Base64.DEFAULT);

    return encoded;
  }


  @ReactMethod
  public void makeTabBarSnapshot(Promise promise) {
    try {
      promise.resolve(this.makeSnapShot());
    } catch (Exception e) {
      promise.reject(e);
    }
  }
}
