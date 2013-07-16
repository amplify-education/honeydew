package com.amplify.honeydew_server.actions;

import android.util.Log;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;
import com.android.uiautomator.core.*;

import java.util.Map;

public class ScrollToTextByIndex extends Action {
    public ScrollToTextByIndex(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        Log.i("ScrollToTextByIndex", "Found index field: " + arguments.get("index"));

        String text = (String) arguments.get("text");
        int index = Integer.parseInt((String) arguments.get("index"));

        UiSelector scrollSelector = new UiSelector().scrollable(true).index(index);
        UiScrollable uiScrollable = new UiScrollable(scrollSelector);

        if(isUiObjectAvailable(uiScrollable, arguments)){
            uiScrollable.scrollTextIntoView(text);
            return Result.OK;
        }

        return Result.FAILURE;
    }
}
