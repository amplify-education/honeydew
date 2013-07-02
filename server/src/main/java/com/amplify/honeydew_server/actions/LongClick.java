package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;

import java.util.Map;

public class LongClick extends Action {
    public LongClick(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        getUiObject(arguments).longClick();
        return Result.OK;
    }
}
