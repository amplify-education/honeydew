package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.*;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;

import java.util.Map;

public class LaunchApp extends Action {
    public LaunchApp(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String appName = (String) arguments.get("appName");
        getUiDevice().pressHome();
        new UiObject(new UiSelector().description("Apps")).click();

        UiScrollable appViews = new UiScrollable(new UiSelector().scrollable(true));
        appViews.setAsHorizontalList();
        appViews.getChildByText(new UiSelector().className(android.widget.TextView.class.getName()), appName).clickAndWaitForNewWindow();
        return Result.OK;
    }
}
