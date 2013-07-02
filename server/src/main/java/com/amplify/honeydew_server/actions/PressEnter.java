package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.*;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;

import java.util.Map;

public class PressEnter extends Action {
    public PressEnter(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        getUiDevice().pressEnter();
        return Result.OK;
    }
}
