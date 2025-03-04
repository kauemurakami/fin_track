# Preserva código do Flutter e classes usadas dinamicamente
-keep class io.flutter.** { *; }
-keep class com.example.** { *; }

# Mantém classes usadas via reflexão
-keepattributes *Annotation*
-keep class * implements android.os.Parcelable { *; }
-keep class * extends androidx.lifecycle.ViewModel { *; }

# Evita remoção de código serializável
-keep class * implements java.io.Serializable { *; }

-dontwarn com.google.android.play.core.splitcompat.SplitCompatApplication
-dontwarn com.google.android.play.core.splitinstall.SplitInstallException
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManager
-dontwarn com.google.android.play.core.splitinstall.SplitInstallManagerFactory
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest$Builder
-dontwarn com.google.android.play.core.splitinstall.SplitInstallRequest
-dontwarn com.google.android.play.core.splitinstall.SplitInstallSessionState
-dontwarn com.google.android.play.core.splitinstall.SplitInstallStateUpdatedListener
-dontwarn com.google.android.play.core.tasks.OnFailureListener
-dontwarn com.google.android.play.core.tasks.OnSuccessListener
-dontwarn com.google.android.play.core.tasks.Task
