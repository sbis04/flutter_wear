<p align="center">
  <img src="https://github.com/sbis04/flutter_wear/raw/master/screenshots/cover.png" alt="Flutter Wear"/>
</p> 

<h4 align="center">This is a Flutter plugin for WearOS devices</h4>

## Features

* Helps in getting the **shape** (square or round) of the watch face
* Handles the mode changes, **Active Mode** and **Ambient Mode**

More features will be arriving soon.

<h4 align="center">EXAMPLE APP</h4>

<p align="center">
  <img src="https://github.com/sbis04/flutter_wear/raw/master/screenshots/wear_example.png" alt="Flutter Wear App"/>
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
  ```

* Inside the same file, update the contents of the `application` tag like this:
  ```xml
  <!-- KEEP THE application tag ATTRIBUTES AS IT IS -->
  <application
        android:name="io.flutter.app.FlutterApplication"
        android:label="wear_demo"
        android:icon="@mipmap/ic_launcher">

        <!-- REPLACE THE PART STARTING FROM BELOW -->
        <!-- Flags that the app doesn't require a companion phone app -->
        <meta-data
        android:name="com.google.android.wearable.standalone"
        android:value="true" />

        <activity
            android:name=".MainActivity"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">

            <meta-data
              android:name="io.flutter.app.android.NormalTheme"
              android:resource="@style/NormalTheme"
              />

            <meta-data
              android:name="io.flutter.app.android.SplashScreenDrawable"
              android:resource="@drawable/launch_background"
              />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <!-- TILL THE ABOVE LINE -->
    </application>
  ```


* Go to `<project root>/android/app/src/main/kotlin/<app_id>/MainActivity.kt` and update the `MainActivity` code as following:
  ```kotlin
  // Except the package name
  // Replace everything

  import android.os.Bundle

  // Do not import this package: 
  // io.flutter.embedding.android.FlutterActivity

  // Make sure that you import the exact same packages here
  import io.flutter.app.FlutterActivity
  import io.flutter.plugins.GeneratedPluginRegistrant
  
  import androidx.wear.ambient.AmbientMode
  
  // Here, replace the app id with yours or, 
  // just open the android folder using Android Studio & 
  // import the following two packages
  import com.souvikbiswas.flutter_wear.FlutterAmbientCallback
  import com.souvikbiswas.flutter_wear.getChannel
  
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

* **WearShape**: Determines the *shape* of the watch face, whether it is square or round.
* **WearMode**: Determines the *current mode* of the watch (*Active Mode* or *Ambient Mode*). The widgets inside it rebuilds whenever the mode changes.
* **WearInheritedShape**: It can be used for passing the shape of the watch down the widget tree.

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
## License

Copyright (c) 2020 Souvik Biswas

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
