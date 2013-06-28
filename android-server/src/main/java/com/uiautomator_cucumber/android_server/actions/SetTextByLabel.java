package com.amplify.honeydew.actions;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.android.uiautomator.core.UiSelector;
import com.amplify.honeydew.Action;
import com.amplify.honeydew.Result;

import java.util.Map;

public class SetTextByLabel extends Action {

    public SetTextByLabel(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String label = (String) arguments.get("label");
        String inputText = (String) arguments.get("text");
        UiObject textField = null;
        textField = new UiObject(new UiSelector().text(label));
        textField.setText(inputText);
        uiDevice.pressDPadDown();
        return Result.OK;
    }
}
