package com.amplify.honeydew_server;

import android.util.Log;
import android.view.KeyEvent;
import com.amplify.honeydew_server.httpd.RemoteCommandReceiver;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.testrunner.UiAutomatorTestCase;

public class TestRunner extends UiAutomatorTestCase {

    private static final String TAG = TestRunner.class.getSimpleName();

    public void testRemoteLoop() throws Exception {
        Log.d(TAG, "Starting honeydew-server...");

        UiDevice uiDevice = getUiDevice();
        uiDevice.wakeUp();
        unlockEmulator();

        RemoteCommandReceiver remoteCommandReceiver =  new RemoteCommandReceiver(new ActionsExecutor(uiDevice));
        remoteCommandReceiver.start();

        Log.d(TAG, "honeydew-server started, waiting for commands");
        while(true) {
            Thread.sleep(1000);
        }
    }

    private void unlockEmulator() {
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_SOFT_LEFT);
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_SOFT_RIGHT);
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_MENU);
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_MENU);
    }
}
