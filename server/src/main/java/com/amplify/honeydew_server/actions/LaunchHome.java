package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class LaunchHome extends Action {
    public LaunchHome(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        getUiDevice().pressHome();
        return Result.OK;
    }
}
