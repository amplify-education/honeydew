package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.uiautomator_cucumber.android_server.Action;
import com.uiautomator_cucumber.android_server.Result;

import java.util.Map;

public class IsTextPresent extends Action {
    public IsTextPresent(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        return getUiObject(arguments).exists() ? Result.OK : Result.FAILURE;
    }
}
