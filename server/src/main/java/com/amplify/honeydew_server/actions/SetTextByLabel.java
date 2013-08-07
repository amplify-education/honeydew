package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class SetTextByLabel extends Action {

    public SetTextByLabel(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String label = (String) arguments.get("label");
        String inputText = (String) arguments.get("text");
        UiObject textField = new UiObject(new UiSelector().text(label));

        if (isUiObjectAvailable(textField, arguments)) {
            textField.setText(inputText);
            uiDevice.pressDPadDown();
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
