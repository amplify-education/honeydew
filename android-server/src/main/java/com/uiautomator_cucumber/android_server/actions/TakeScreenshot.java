package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.uiautomator_cucumber.android_server.Action;
import com.uiautomator_cucumber.android_server.Result;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.Map;

public class TakeScreenshot extends Action {
    public TakeScreenshot(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        try {
            FileUtils.forceMkdir(new File("/data/local/tmp/local/tmp/"));
        } catch (IOException e) {
            return new Result("Create directory failed", e);
        }
        uiDevice.dumpWindowHierarchy("honeydew-window-hierarchy");
        return new Result(true, "/data/local/tmp/local/tmp/honeydew-window-hierarchy");
    }
}
