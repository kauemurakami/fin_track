package com.example.fin_track

import android.app.Activity
import android.os.Build
import android.os.Process
import kotlin.system.exitProcess

class EmulatorChecker {
    companion object {
        fun checkEmulatorAndExit(activity: Activity) {
            if (isEmulator()) {
                activity.finishAffinity() // Fecha todas as Activities
                Process.killProcess(Process.myPid()) // Mata o processo
                exitProcess(0) // Encerra o app
            }
        }

        private fun isEmulator(): Boolean {
            val buildProps = listOf(
                Build.FINGERPRINT.startsWith("generic"),
                Build.MODEL.contains("google_sdk"),
                Build.MODEL.contains("Emulator"),
                Build.MODEL.contains("Android SDK built for x86"),
                Build.MANUFACTURER.contains("Genymotion"),
                Build.BRAND.startsWith("generic") && Build.DEVICE.startsWith("generic"),
                "google_sdk" == Build.PRODUCT,
                Build.HARDWARE.contains("goldfish") || Build.HARDWARE.contains("ranchu"),
                Build.PRODUCT.contains("sdk_google"),
                Build.PRODUCT.contains("sdk"),
                Build.PRODUCT.contains("sdk_x86"),
                Build.PRODUCT.contains("sdk_gphone"),
                Build.PRODUCT.contains("vbox86p"),
                Build.BOARD.contains("unknown")
            )

            return buildProps.contains(true)
        }
    }
}
