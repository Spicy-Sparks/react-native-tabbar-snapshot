package com.marf.RNTabBarSnapshot;

import android.app.Activity;

import com.facebook.react.ReactPackage;
import com.facebook.react.bridge.JavaScriptModule;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.uimanager.ViewManager;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class RNTabBarSnapshotPackage implements ReactPackage {

  private int bottomTabsId = -1;

  public RNTabBarSnapshotPackage(int bottomTabsId){
    this.bottomTabsId = bottomTabsId;
  }

  @Override
  public List<NativeModule> createNativeModules(ReactApplicationContext reactContext) {
    return Arrays.<NativeModule>asList(new RNTabBarSnapshotModule(reactContext, this.bottomTabsId));
  }

  @Override
  public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
    return Collections.emptyList();
  }
}
