package com.amplify.honeydew_server.actions;

import android.util.Log;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;
import com.android.uiautomator.core.UiCollection;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.android.uiautomator.core.UiSelector;

import java.util.Map;

public abstract class AbstractChildCountAction extends Action {
    public AbstractChildCountAction(UiDevice uiDevice) {
        super(uiDevice);
    }

    protected abstract boolean isTrue(int childCount, int count);

    @Override
    public final Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        Log.d(TAG, "Entering " + TAG);
        String parentDescription = (String) arguments.get("parent_description");
        String childDescription = (String) arguments.get("child_description");
        int expectedCount = ((Double) arguments.get("child_count")).intValue();

        UiCollection parentElement = new UiCollection(new UiSelector().description(parentDescription));
        int actualCount = parentElement.getChildCount(new UiSelector().description(childDescription));
        Log.d(TAG, "Actual count was: " + actualCount + " when " + expectedCount + " was expected");
        return new Result(isTrue(expectedCount, actualCount), "Actual count was: " + actualCount + " when " + expectedCount + " was expected");

    }
}
