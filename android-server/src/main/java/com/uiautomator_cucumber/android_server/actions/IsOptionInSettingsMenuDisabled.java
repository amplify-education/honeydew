package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.UiDevice;

public class IsOptionInSettingsMenuDisabled extends InspectOptionInSettingsMenu {
    public IsOptionInSettingsMenuDisabled(UiDevice uiDevice) {
        super(uiDevice, false);
    }
}
