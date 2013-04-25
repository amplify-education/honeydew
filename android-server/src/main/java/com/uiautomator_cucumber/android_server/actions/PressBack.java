package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.*;
import com.uiautomator_cucumber.android_server.Action;
import com.uiautomator_cucumber.android_server.Result;

import java.util.Map;

public class PressBack extends Action {
    public PressBack(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        getUiDevice().pressBack();
        return Result.OK;
    }
}
