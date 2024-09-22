# Keep all Firebase services and classes
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep specific Firebase Messaging classes
-keep class com.google.firebase.messaging.** { *; }

# Android WorkManager specific rules
-keep class androidx.work.impl.background.systemalarm.SystemAlarmService
-keep class androidx.work.impl.background.systemjob.SystemJobService
-keep class androidx.work.impl.constraints.trackers.Trackers
-keep class androidx.work.impl.utils.ForceStopRunnable
-keep class androidx.work.impl.utils.taskexecutor.TaskExecutor
-keep class androidx.work.WorkerParameters

# Gson specific classes
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.stream.** { *; }

# Application classes that will be serialized/deserialized over Gson
-keep class com.yourapp.model.** { *; }

# Preserve all native method names and the names of their classes.
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep all classes that extend Android components
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.Application

# Keep custom views and their constructors
-keepclassmembers class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
}

# Keep enum classes and their methods
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

