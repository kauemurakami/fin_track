package com.example.fin_track


import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.fin_track.RootChecker
import com.example.fin_track.HooksChecker

class MainActivity : FlutterActivity(){
    // private val ROOT_CHECK_CHANNEL = "security_check"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
          RootChecker.checkRootAndExit(this)
          HooksChecker.checkHookingAndExit(this)
        // MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ROOT_CHECK_CHANNEL).setMethodCallHandler { call, result ->
        //     if (call.method == "isRooted") {
        //         result.success(RootChecker.isDeviceRooted()) // Chamando a função da classe separada
        //     } else {
        //         result.notImplemented()
        //     }
        // }
    }
}
