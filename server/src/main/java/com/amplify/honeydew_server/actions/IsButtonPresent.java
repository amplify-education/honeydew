package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class IsButtonPresent extends Action {
    public IsButtonPresent(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String text = (String) arguments.get("text");
        UiObject textView = new UiObject(new UiSelector().className(android.widget.Button.class.getName()).textContains(text));
        return isUiObjectAvailable(textView, arguments) ? Result.OK : Result.FAILURE;
    }
}
