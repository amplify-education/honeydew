package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.android.uiautomator.core.UiSelector;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;

import java.util.Map;

public class SetText extends Action {

    public SetText(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String textDescription = (String) arguments.get("description");
        String text = (String) arguments.get("text");

        UiObject textField = new UiObject(new UiSelector().description(textDescription));

        if(isUiObjectAvailable(textField, arguments)){
            textField.setText(text);
            uiDevice.pressDPadDown();
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
