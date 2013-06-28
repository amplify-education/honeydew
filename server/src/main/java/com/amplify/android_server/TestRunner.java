package com.amplify.honeydew;

import android.view.KeyEvent;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.testrunner.UiAutomatorTestCase;
import com.amplify.honeydew.httpd.RemoteCommandReceiver;

public class TestRunner extends UiAutomatorTestCase {

    public static final String TAG = "UIAutomatorRemote";

    public void testRemoteLoop() throws Exception {
        UiDevice uiDevice = getUiDevice();
        uiDevice.wakeUp();
        unlockEmulator();

        new RemoteCommandReceiver(new ActionsExecutor(uiDevice));
    }

    private void unlockEmulator() {
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_SOFT_LEFT);
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_SOFT_RIGHT);
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_MENU);
        getUiDevice().pressKeyCode(KeyEvent.KEYCODE_MENU);
    }
}
