package com.amplify.honeydew.actions;

import com.android.uiautomator.core.*;
import com.amplify.honeydew.Action;
import com.amplify.honeydew.Result;

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
