package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObjectNotFoundException;

import java.util.Map;

public class IsRegexMatchPresent extends Action {

    public IsRegexMatchPresent(UiDevice uiDevice){
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        return isUiObjectAvailable(getUiObject(arguments), arguments) ? Result.OK : Result.FAILURE;
    }
}
