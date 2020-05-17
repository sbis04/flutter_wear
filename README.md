# Flutter Wear

This is a Flutter plugin for **WearOS** devices. 

## Features

* Helps in getting the **shape** (square or round) of the watch face
* Handles the mode changes, **Active Mode** and **Ambient Mode**

<h4 align="center">EXAMPLE APP</h4>

<p align="center">
  <img src="https://github.com/sbis04/flutter_wear/raw/master/screenshots/wear_example.png" alt="Flutter Wear"/>
</p>

## Usage

* Go to `<project root>/android/app/build.gradle` and set the `minSdkVersion` to **23**:

   ```gradle
   minSdkVersion 23
   ```

* Also add the following dependencies to the same file:
  ```gradle
  dependencies {
    // Wear dependencies
    implementation 'com.android.support:wear:27.1.1'
    implementation 'com.google.android.support:wearable:2.3.0'
    compileOnly 'com.google.android.wearable:wearable:2.3.0'
  }
  ```

* Go to `<project root>/android/app/src/main/AndroidManifest.xml` and add the following inside the `manifest` tag:
  ```xml
  <!-- Required for ambient mode support -->
  <uses-permission android:name="android.permission.WAKE_LOCK" />
  
  <!-- Flags the app as a Wear app -->
  <uses-feature android:name="android.hardware.type.watch" />
  
  <!-- Flags that the app doesn't require a companion phone app -->
  <application>
  <meta-data
      android:name="com.google.android.wearable.standalone"
      android:value="true" />
  </application>
  ```

* Go to `<project root>/android/app/src/main/kotlin/<app_id>/MainActivity.kt` and update the `MainActivity` code as following:
  ```kotlin
  class MainActivity: FlutterActivity(), AmbientMode.AmbientCallbackProvider {
    override fun onCreate(savedInstanceState: Bundle?) {
      super.onCreate(savedInstanceState)
      GeneratedPluginRegistrant.registerWith(this)
  
      // Wire up the activity for ambient callbacks
      AmbientMode.attachAmbientSupport(this)
    }
  
    override fun getAmbientCallback(): AmbientMode.AmbientCallback {
      return FlutterAmbientCallback(getChannel(flutterView))
    }
  }
  ```

## Widgets


