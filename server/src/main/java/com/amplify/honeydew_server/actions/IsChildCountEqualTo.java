package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.UiDevice;

public class IsChildCountEqualTo extends AbstractChildCountAction {

    public IsChildCountEqualTo(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    protected boolean isTrue(int childCount, int count) {
        return childCount == count;
    }


}
