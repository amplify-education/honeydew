package com.amplify.honeydew.actions;

import com.android.uiautomator.core.UiDevice;

public class IsOptionInSettingsMenuEnabled extends InspectOptionInSettingsMenu {
    public IsOptionInSettingsMenuEnabled(UiDevice uiDevice) {
        super(uiDevice, true);
    }
}
