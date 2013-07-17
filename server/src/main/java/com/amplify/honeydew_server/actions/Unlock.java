package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.android.uiautomator.core.UiSelector;

import java.util.Map;

public class Unlock extends Action {
    public Unlock(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        UiObject uiObject = new UiObject(new UiSelector().description("Slide area."));
        uiObject = isUiObjectAvailable(uiObject, arguments) ? uiObject : new UiObject(new UiSelector().className("android.view.View"));
        try {
            if (isUiObjectAvailable(uiObject, arguments)) {
                uiObject.swipeRight(100);
            }
        } catch (UiObjectNotFoundException e) {
            // The device is unlocked already?"
        }
        getUiDevice().pressHome();
        return Result.OK;
    }
}
