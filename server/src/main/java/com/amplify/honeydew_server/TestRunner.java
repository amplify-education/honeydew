package com.amplify.honeydew_server;

import android.util.Log;
import android.view.KeyEvent;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.testrunner.UiAutomatorTestCase;
import com.amplify.honeydew_server.httpd.RemoteCommandReceiver;
import fi.iki.elonen.ServerRunner;

public class TestRunner extends UiAutomatorTestCase {

    public void testRemoteLoop() throws Exception {
        Log.d(getClass().getName(), "Starting honeydew-server...");

        UiDevice uiDevice = getUiDevice();
        uiDevice.wakeUp();
        unlockEmulator();

        RemoteCommandReceiver remoteCommandReceiver =  new RemoteCommandReceiver(new ActionsExecutor(uiDevice));
        ServerRunner.executeInstance(remoteCommandReceiver);

        Log.d(getClass().getName(), "honeydew-server started, waiting for commands");
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
