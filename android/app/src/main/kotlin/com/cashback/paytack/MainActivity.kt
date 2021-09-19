package com.cashback.paytack
import io.flutter.embedding.engine.FlutterEngine;
import android.content.Intent
import android.os.Bundle
import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {

    private val CHANNEL = "test_activity"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        MethodChannel(getFlutterEngine()?.getDartExecutor()?.getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                object : MethodCallHandler {
                    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
                        if(call.method.equals("startNewActivity")) {
                            startNewActivity()
                        }
                    }
                })
    }

    private fun startNewActivity() {
        val intent = Intent(this, MainLinkUiActivity::class.java)
        startActivity(intent)
    }

}