package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.UiDevice;

public class IsChildCountGreaterThan extends AbstractChildCountAction {

    public IsChildCountGreaterThan(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    protected boolean isTrue(int expectedCount, int actualCount) {
        return actualCount > expectedCount;
    }

}
