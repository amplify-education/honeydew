package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class IsTextPresent extends Action {
    public IsTextPresent(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        return isUiObjectAvailable(getUiObject(arguments), arguments) ? Result.OK : Result.FAILURE;
    }
}
