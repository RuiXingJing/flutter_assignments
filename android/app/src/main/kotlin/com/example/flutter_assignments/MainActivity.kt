package com.example.flutter_assignments

import android.os.Bundle
import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.analytics.Analytics
import com.microsoft.appcenter.crashes.Crashes
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        AppCenter.start(
            application, "c27ffa2e-606a-4a10-a952-aef1e0aa664f",
            Analytics::class.java, Crashes::class.java
        )
    }
}
