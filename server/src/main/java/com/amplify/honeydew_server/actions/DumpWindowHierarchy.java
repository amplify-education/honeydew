package com.amplify.honeydew_server.actions;

import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;
import org.apache.commons.io.FileUtils;

import java.io.*;
import java.util.Map;

public class DumpWindowHierarchy extends Action {
    public DumpWindowHierarchy(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        try {
            FileUtils.forceMkdir(new File("/data/local/tmp/local/tmp/"));
        } catch (IOException e) {
            return new Result("Create directory failed", e);
        }
        uiDevice.dumpWindowHierarchy("honeydew_server-window-hierarchy");
        return new Result(true, "/data/local/tmp/local/tmp/honeydew_server-window-hierarchy");
    }
}
