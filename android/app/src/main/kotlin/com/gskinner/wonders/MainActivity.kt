package com.gskinner.flutter.wonders

import android.os.Bundle
import com.google.android.gms.maps.MapsInitializer
import com.google.android.gms.maps.OnMapsSdkInitializedCallback
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity(), OnMapsSdkInitializedCallback {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        MapsInitializer.initialize(applicationContext, MapsInitializer.Renderer.LATEST, this)
    }

    override fun onMapsSdkInitialized(p0: MapsInitializer.Renderer) {}
}
