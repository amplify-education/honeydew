package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.*;
import com.uiautomator_cucumber.android_server.Action;
import com.uiautomator_cucumber.android_server.Result;

import java.util.Map;

public class IsElementWithNestedTextPresent extends Action {
    public IsElementWithNestedTextPresent(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String parentDescription = (String) arguments.get("parent_description");
        String childText = (String) arguments.get("child_text");

        UiCollection parentElement = new UiCollection(new UiSelector().description(parentDescription));
        UiObject child = parentElement.getChild(new UiSelector().text(childText));
        return child.exists() ? Result.OK : Result.FAILURE;
    }

}
