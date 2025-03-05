package com.example.fin_track

import android.app.Activity
import android.os.Build
import android.os.Process
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader
import kotlin.system.exitProcess

class RootChecker {
    companion object {
        fun checkRootAndExit(activity: Activity) {
            if (isRooted()) {
                activity.finishAffinity() // Fecha todas as activities
                Process.killProcess(Process.myPid()) // Mata o processo
                exitProcess(0) // Sai do app
            }
        }

        private fun isRooted(): Boolean {
            return checkSuFiles() || checkCommands() || checkSystemProps()
        }

        // 🚨 Verifica se existem arquivos típicos de root
        private fun checkSuFiles(): Boolean {
            val paths = arrayOf(
                "/system/app/Superuser.apk",
                "/system/xbin/su",
                "/system/bin/su",
                "/system/bin/.ext/.su",
                "/system/sd/xbin/su",
                "/sbin/su",
                "/system/etc/init.d/99SuperSUDaemon",
                "/system/xbin/daemonsu",
                "/system/bin/.ext/.su",
                "/data/local/xbin/su",
                "/data/local/bin/su",
                "/system/su",
                "/system/bin/magisk",
                "/sbin/magisk",
                "/data/local/tmp/magisk",
                "/system/bin/magiskhide",
                "/sbin/magiskhide",
                "/data/local/tmp/magiskhide"
            )

            for (path in paths) {
                if (File(path).exists()) {
                    return true
                }
            }

            return false
        }

        // 🚨 Verifica comandos perigosos como `su` e `magisk`
        private fun checkCommands(): Boolean {
            val commands = arrayOf(
                "which su",
                "which magisk",
                "which busybox",
                "which daemonsu"
            )

            for (cmd in commands) {
                if (executeCommand(cmd)) {
                    return true
                }
            }

            return false
        }

        // 🚨 Verifica propriedades do sistema (`getprop`)
        private fun checkSystemProps(): Boolean {
            val properties = arrayOf(
                "ro.build.tags",        // Deve ser "release-keys", se for "test-keys" indica root
                "ro.debuggable",        // Se for 1, o sistema é debuggable (indica root)
                "ro.secure",            // Se for 0, o sistema não é seguro (indica root)
                "ro.bootmode",          // Se for "recovery" ou "fastboot", pode ser root
                "ro.hardware",          // Alguns hardwares têm permissões root ativadas
                "ro.boot.verifiedbootstate" // Se for "orange" ou "yellow", indica root
            )

            for (prop in properties) {
                val value = getSystemProperty(prop)
                if (value != null) {
                    if (prop == "ro.build.tags" && value.contains("test-keys")) return true
                    if (prop == "ro.debuggable" && value == "1") return true
                    if (prop == "ro.secure" && value == "0") return true
                    if (prop == "ro.bootmode" && (value == "recovery" || value == "fastboot")) return true
                    if (prop == "ro.boot.verifiedbootstate" && (value == "orange" || value == "yellow")) return true
                }
            }

            return false
        }

        // 🛠️ Executa um comando no shell e verifica se retorna algo
        private fun executeCommand(command: String): Boolean {
            return try {
                val process = Runtime.getRuntime().exec(command)
                val input = BufferedReader(InputStreamReader(process.inputStream))
                val output = input.readLine()
                output != null
            } catch (e: Exception) {
                false
            }
        }

        // 🛠️ Lê uma propriedade do sistema (`getprop`)
        private fun getSystemProperty(prop: String): String? {
            return try {
                val process = Runtime.getRuntime().exec("getprop $prop")
                val input = BufferedReader(InputStreamReader(process.inputStream))
                input.readLine()
            } catch (e: Exception) {
                null
            }
        }
    }
}
