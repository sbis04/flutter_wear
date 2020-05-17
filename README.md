# Flutter Wear

This is a Flutter plugin for **WearOS** devices. 

## Features

* Helps in getting the **shape** (square or round) of the watch face
* Handles the mode changes, **Active Mode** and **Ambient Mode**

<h4 align="center">EXAMPLE APP</h4>

<p align="center">
  <img src="https://github.com/sbis04/flutter_wear/raw/master/screenshots/wear_example.png" alt="Flutter Wear"/>
</p>

> ***NOTE:*** The project is not using *Fluter Embedding v2*

## Usage

* Add the dependency `flutter_wear` to your **pubspec.yaml** file.

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

There are three primary widgets:



## Example

```dart
import 'package:flutter/material.dart';
import 'package:flutter_wear/mode.dart';
import 'package:flutter_wear/shape.dart';
import 'package:flutter_wear/wear_mode.dart';
import 'package:flutter_wear/wear_shape.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _containerColor;
  Color _textColor;

  @override
  void initState() {
    super.initState();

    _containerColor = Colors.white;
    _textColor = Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WearShape(
            builder: (context, shape) => WearMode(builder: (context, mode) {
              if (mode == Mode.active) {
                _containerColor = Colors.white;
                _textColor = Colors.black;
              } else {
                _containerColor = Colors.black;
                _textColor = Colors.white;
              }
              return Container(
                color: _containerColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(),
                    FlutterLogo(size: 100),
                    Text(
                      'Shape: ${shape == Shape.round ? 'round' : 'square'}',
                      style: TextStyle(color: _textColor),
                    ),
                    Text(
                      'Mode: ${mode == Mode.active ? 'Active' : 'Ambient'}',
                      style: TextStyle(color: _textColor),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
```

