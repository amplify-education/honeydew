package com.amplify.honeydew.actions;

import com.android.uiautomator.core.UiDevice;

public class IsOptionInSettingsMenuDisabled extends InspectOptionInSettingsMenu {
    public IsOptionInSettingsMenuDisabled(UiDevice uiDevice) {
        super(uiDevice, false);
    }
}
