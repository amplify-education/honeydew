package com.uiautomator_cucumber.android_server;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.google.common.base.CaseFormat;

import java.util.Map;

public abstract class Action {
    protected final UiDevice uiDevice;

    public Action(UiDevice uiDevice) {
        this.uiDevice = uiDevice;
    }

    public abstract Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException;

    public String name() {
        return CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, getClass().getSimpleName());
    }

    protected UiDevice getUiDevice() {
        return uiDevice;
    }
}
