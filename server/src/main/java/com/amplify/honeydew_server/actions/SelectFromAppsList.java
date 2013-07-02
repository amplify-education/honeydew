package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.*;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;

import java.util.Map;

public class SelectFromAppsList extends Action {
    public SelectFromAppsList(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String appName = (String)arguments.get("appName");
        //TODO: Using a better selector
        UiScrollable settingsMenu = new UiScrollable(new UiSelector().scrollable(true).focused(false));
        settingsMenu.setAsVerticalList();

        (settingsMenu.getChildByText(new UiSelector().className(android.widget.TextView.class.getName()),appName)).click();
        return Result.OK;
    }
}
