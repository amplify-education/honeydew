package com.amplify.honeydew.actions;

import android.util.*;
import com.android.uiautomator.core.*;
import com.amplify.honeydew.*;

import java.util.*;

public class SetTextByIndex extends Action {

    public SetTextByIndex(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        Log.i("SetTextByIndex", "Found index field: " + arguments.get("index"));
        int index = Integer.parseInt((String) arguments.get("index"));
        String text = (String) arguments.get("text");
        UiObject textField = new UiObject(new UiSelector().className("android.widget.EditText").index(index));
        Log.i("SetTextByIndex", "Found text field: " + textField);
        textField.setText(text);
        return Result.OK;
    }
}
