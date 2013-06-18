package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.UiDevice;

public class IsOptionInSettingsMenuEnabled extends InspectOptionInSettingsMenu {
    public IsOptionInSettingsMenuEnabled(UiDevice uiDevice) {
        super(uiDevice, true);
    }
}
