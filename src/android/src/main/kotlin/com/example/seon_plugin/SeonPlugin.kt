package com.example.seon_plugin

import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.seon.androidsdk.exception.SeonException
import io.seon.androidsdk.service.SeonBuilder

/** SeonPlugin */
class SeonPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "seon_plugin")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getFingerPrint" -> {
                val sessionId: String = call.argument<String>("sessionId") as String
                val isLoggingEnabled: Boolean =
                    call.argument<Boolean>("isLoggingEnabled") as Boolean
                getSeonFingerPrint(sessionId, isLoggingEnabled, result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    private fun getSeonFingerPrint(
        sessionId: String,
        isLoggingEnabled: Boolean,
        @NonNull result: Result
    ) {
        //Build with parameters
        val sfp =
            SeonBuilder().withContext(applicationContext).withSessionId(sessionId)
                .build()

        // Enable logging
        sfp.setLoggingEnabled(isLoggingEnabled)
        try {
            sfp.getFingerprintBase64 { seonResult: String? ->
                result.success(seonResult)
            }

        } catch (e: SeonException) {
            e.printStackTrace()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}