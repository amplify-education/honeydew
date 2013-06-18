package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.*;
import com.uiautomator_cucumber.android_server.Action;
import com.uiautomator_cucumber.android_server.Result;

import java.util.Map;

public class SelectMenuInSettings extends Action {
    public SelectMenuInSettings(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String menuName = (String) arguments.get("menuName");
        UiScrollable settingsMenu = new UiScrollable(new UiSelector().scrollable(true).focused(true));

        (settingsMenu.getChildByText(new UiSelector().className(android.widget.TextView.class.getName()),menuName)).click();
        return Result.OK;
    }
}
