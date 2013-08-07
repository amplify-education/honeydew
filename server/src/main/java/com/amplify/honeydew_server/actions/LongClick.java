package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class LongClick extends Action {
    public LongClick(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        final UiObject uiObject = getUiObject(arguments);

        if(isUiObjectAvailable(uiObject, arguments)){
            uiObject.longClick();
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
