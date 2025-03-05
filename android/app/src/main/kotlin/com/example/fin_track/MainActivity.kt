package com.example.fin_track


import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import com.example.fin_track.RootChecker
import com.example.fin_track.HooksChecker
import com.example.fin_track.EmulatorChecker

class MainActivity : FlutterActivity(){
    // private val ROOT_CHECK_CHANNEL = "security_check"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
          RootChecker.checkRootAndExit(this) //verifica se é root
          HooksChecker.checkHookingAndExit(this) //verifica se possui algum hook
          EmulatorChecker.checkEmulatorAndExit(this) // verifica se está rodando em dispositivo fisico

        // MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ROOT_CHECK_CHANNEL).setMethodCallHandler { call, result ->
        //     if (call.method == "isRooted") {
        //         result.success(RootChecker.isDeviceRooted()) // Chamando a função da classe separada
        //     } else {
        //         result.notImplemented()
        //     }
        // }
    }
}
