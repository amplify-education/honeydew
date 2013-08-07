package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class SetTextByIndex extends Action {

    public SetTextByIndex(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        int index = Integer.parseInt((String) arguments.get("index"));
        String text = (String) arguments.get("text");
        UiObject textField = new UiObject(new UiSelector().className("android.widget.EditText").index(index));

        if (isUiObjectAvailable(textField, arguments)) {
            textField.setText(text);
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
