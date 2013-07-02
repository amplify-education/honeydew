package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.UiDevice;

public class IsOptionInSettingsMenuDisabled extends InspectOptionInSettingsMenu {
    public IsOptionInSettingsMenuDisabled(UiDevice uiDevice) {
        super(uiDevice, false);
    }
}
