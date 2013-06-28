package com.amplify.honeydew.actions;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.android.uiautomator.core.UiSelector;
import com.amplify.honeydew.Action;
import com.amplify.honeydew.Result;

import java.util.Map;

public class Unlock extends Action {
    public Unlock(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        UiObject uiObject = new UiObject(new UiSelector().description("Slide area."));
        uiObject = uiObject.exists() ? uiObject : new UiObject(new UiSelector().className("android.view.View"));
        try {
            if (uiObject.exists()) {
                uiObject.swipeRight(100);
            }
        } catch (UiObjectNotFoundException e) {
            // The device is unlocked already?"
        }
        getUiDevice().pressHome();
        return Result.OK;
    }
}
