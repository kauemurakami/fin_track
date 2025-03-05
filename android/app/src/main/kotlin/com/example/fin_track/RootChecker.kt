package com.example.fin_track

import android.app.Activity
import android.os.Process
import java.io.File
import kotlin.system.exitProcess

class RootChecker {
    companion object {
        fun checkRootAndExit(activity: Activity) {
            val paths = arrayOf(
                "/system/app/Superuser.apk",
                "/system/xbin/su",
                "/system/bin/su",
                "/system/bin/.ext/.su",
                "/system/sd/xbin/su",
                "/sbin/su"
            )
            for (path in paths) {
                if (File(path).exists()) {
                    activity.finishAffinity() // Fecha todas as activities
                    Process.killProcess(Process.myPid()) // Mata o processo
                    exitProcess(0) // Sai do app
                }
            }
        }
    }
}
