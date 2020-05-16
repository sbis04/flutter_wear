package com.souvikbiswas.flutter_wear

import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.PluginRegistry.Registrar
import io.flutter.view.FlutterView

import android.app.Activity
import android.os.Bundle

import androidx.core.view.ViewCompat.requestApplyInsets
import androidx.core.view.ViewCompat.setOnApplyWindowInsetsListener
import androidx.core.view.WindowInsetsCompat

import androidx.wear.ambient.AmbientMode

/** FlutterWearPlugin */
private const val CHANNEL_NAME = "flutter_wear"

fun getChannel(view: FlutterView): MethodChannel {
  return MethodChannel(view, CHANNEL_NAME)
}

class FlutterWearPlugin private constructor(
        activity: Activity,
        private val view: FlutterView,
        val channel: MethodChannel) :
        MethodCallHandler {

  private var mAmbientController: AmbientMode.AmbientController? = null

  init {
    // Set the Flutter ambient callbacks
    mAmbientController = AmbientMode.attachAmbientSupport(activity)
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), CHANNEL_NAME)
      channel.setMethodCallHandler(FlutterWearPlugin(registrar.activity(),
              registrar.view(), channel))
    }
  }



  override fun onMethodCall(call: MethodCall, result: Result) {
    when {
      call.method == "getPlatformVersion" ->
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      call.method == "retrieveShape" -> handleShapeMethodCall(result)
      else -> result.notImplemented()
    }
  }

  private fun handleShapeMethodCall(result: Result) {
    setOnApplyWindowInsetsListener(view, { _, insets: WindowInsetsCompat? ->
      if (insets?.isRound == true) {
        result.success(0)
      } else {
        result.success(1)
      }
      WindowInsetsCompat(insets)
    })
    requestApplyInsets(view)
  }
}

/*
 * Pass ambient callback back to Flutter
 */
class FlutterAmbientCallback(private val channel: MethodChannel) : AmbientMode.AmbientCallback() {

  override fun onEnterAmbient(ambientDetails: Bundle) {
    channel.invokeMethod("ambientMode", null)
    super.onEnterAmbient(ambientDetails)
  }

  override fun onExitAmbient() {
    channel.invokeMethod("exitAmbientMode", null)
    super.onExitAmbient()
  }

  override fun onUpdateAmbient() {
    channel.invokeMethod("updateMode", null)
    super.onUpdateAmbient()
  }
}



// New Files

//public class FlutterWearPlugin: FlutterPlugin, MethodCallHandler {
//  /// The MethodChannel that will the communication between Flutter and native Android
//  ///
//  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
//  /// when the Flutter Engine is detached from the Activity
//  private lateinit var channel : MethodChannel
//
//  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
//    channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutter_wear")
//    channel.setMethodCallHandler(this);
//  }
//
//  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
//  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
//  // plugin registration via this function while apps migrate to use the new Android APIs
//  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
//  //
//  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
//  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
//  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
//  // in the same class.
//  companion object {
//    @JvmStatic
//    fun registerWith(registrar: Registrar) {
//      val channel = MethodChannel(registrar.messenger(), "flutter_wear")
//      channel.setMethodCallHandler(FlutterWearPlugin())
//    }
//  }
//
//  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//    if (call.method == "getPlatformVersion") {
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
//    } else {
//      result.notImplemented()
//    }
//  }
//
//  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
//    channel.setMethodCallHandler(null)
//  }
//}
