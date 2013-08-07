package com.amplify.honeydew_server.actions;

import android.widget.TextView;
import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class SelectMenuInSettings extends Action {
    public SelectMenuInSettings(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String menuName = (String) arguments.get("menuName");

        final UiScrollable settingsMenu = new UiScrollable(new UiSelector().scrollable(true).focused(true));
        if(!isUiObjectAvailable(settingsMenu,arguments)){
            return Result.FAILURE;
        }

        final UiSelector childPattern = new UiSelector().className(TextView.class.getName());
        final UiObject childByText = settingsMenu.getChildByText(childPattern, menuName);
        if (isUiObjectAvailable(childByText, arguments)) {
            childByText.click();
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
