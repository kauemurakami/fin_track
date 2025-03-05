package com.example.fin_track

import android.app.Activity
import android.os.Process
import java.io.File
import kotlin.system.exitProcess

class HooksChecker {
    companion object {
      //checando os frameworks mais conhecidos
        fun checkHookingAndExit(activity: Activity) {
            if (isFridaPresent() || isShadowPresent() || isXposedPresent() || isSubstratePresent() || isFreedaPresent()) {
                activity.finishAffinity() // Fecha todas as activities
                Process.killProcess(Process.myPid()) // Mata o processo
                exitProcess(0) // Sai do app
            }
        }

        // 🚨 Verifica sinais do Frida
        private fun isFridaPresent(): Boolean {
            val paths = arrayOf(
                "/data/local/tmp/frida-server",
                "/system/bin/frida-server",
                "/system/xbin/frida-server",
                "/data/local/tmp/re.frida.server"
            )

            for (path in paths) {
                if (File(path).exists()) {
                    return true
                }
            }

            return false
        }

        // 🚨 Verifica sinais do Shadow e variantes
        private fun isShadowPresent(): Boolean {
            val hookingLibs = arrayOf(
                "libshadowhook.so",
                "libshadow.so"
            )

            return checkForLibraries(hookingLibs)
        }

        // 🚨 Verifica sinais do Xposed e EdXposed
        private fun isXposedPresent(): Boolean {
            val hookingLibs = arrayOf(
                "libxposed.so",
                "libedxposed.so"
            )

            return checkForLibraries(hookingLibs)
        }

        // 🚨 Verifica sinais do Cydia Substrate
        private fun isSubstratePresent(): Boolean {
            val hookingLibs = arrayOf(
                "libsubstrate.so",
                "libsubstrate-dvm.so"
            )

            return checkForLibraries(hookingLibs)
        }

        // 🚨 Verifica sinais do Freeda
        private fun isFreedaPresent(): Boolean {
            val paths = arrayOf(
                "/data/local/tmp/freeda-server",
                "/system/bin/freeda-server",
                "/system/xbin/freeda-server"
            )

            for (path in paths) {
                if (File(path).exists()) {
                    return true
                }
            }

            return false
        }

        // 🚨 Função genérica para checar se uma biblioteca de hooking está presente
        private fun checkForLibraries(libs: Array<String>): Boolean {
            for (lib in libs) {
                if (File("/system/lib/$lib").exists() || File("/system/lib64/$lib").exists()) {
                    return true
                }
            }
            return false
        }
    }
}
