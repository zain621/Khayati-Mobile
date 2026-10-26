package com.os.khayati

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // ── Prevent the app from restarting at the Splash screen ──────────────
        // When the app is already running in the background (still in the
        // "recent apps" list) and the user reopens it from the launcher icon,
        // Android may deliver a fresh LAUNCHER intent that spawns a *new*
        // MainActivity instance on top of the existing task. That new instance
        // boots a fresh Flutter engine, re-runs Dart `main()`, and drops the
        // user back on Splash — losing the current screen, scroll position and
        // any cached data.
        //
        // If this activity is NOT the root of its task, that duplicate launch
        // has happened: finish it and let the already-running instance resume
        // exactly where the user left off.
        if (!isTaskRoot &&
            intent.hasCategory(Intent.CATEGORY_LAUNCHER) &&
            Intent.ACTION_MAIN == intent.action
        ) {
            finish()
            return
        }
    }
}
