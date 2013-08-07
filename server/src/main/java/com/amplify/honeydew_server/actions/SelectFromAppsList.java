package com.amplify.honeydew_server.actions;

import android.widget.TextView;
import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class SelectFromAppsList extends Action {
    public SelectFromAppsList(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String appName = (String) arguments.get("appName");
        //TODO: Using a better selector
        UiScrollable settingsMenu = new UiScrollable(new UiSelector().scrollable(true).focused(false));

        if (!isUiObjectAvailable(settingsMenu, arguments)) {
            return Result.FAILURE;
        }

        settingsMenu.setAsVerticalList();
        final UiSelector childPattern = new UiSelector().className(TextView.class.getName());
        final UiObject childByText = settingsMenu.getChildByText(childPattern, appName);

        if (isUiObjectAvailable(childByText, arguments)) {
            childByText.click();
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
