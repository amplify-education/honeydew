package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class ClickAndWaitForNewWindow extends Action {
    public ClickAndWaitForNewWindow(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        final UiObject uiObject = getUiObject(arguments);

        if (isUiObjectAvailable(uiObject, arguments)) {
            uiObject.clickAndWaitForNewWindow();
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
