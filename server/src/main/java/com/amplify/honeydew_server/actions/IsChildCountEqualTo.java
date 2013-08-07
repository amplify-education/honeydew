package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class IsChildCountEqualTo extends Action {

    public IsChildCountEqualTo(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        String parentDescription = (String) arguments.get("parent_description");
        String childDescription = (String) arguments.get("child_description");
        int childCount = (Integer) arguments.get("child_count");

        UiCollection parentElement = new UiCollection(new UiSelector().description(parentDescription));
        int count = parentElement.getChildCount(new UiSelector().description(childDescription));
        return new Result(childCount == count, "Actual count was: " + count + " when " + childCount + " was expected");
    }

}
