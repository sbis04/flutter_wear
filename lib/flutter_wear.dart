import 'dart:async';

import 'package:flutter/services.dart';

class FlutterWear {
  static const MethodChannel channel = const MethodChannel('flutter_wear');

  static Future<String> get platformVersion async {
    final String version = await channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
