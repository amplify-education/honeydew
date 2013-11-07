package com.amplify.honeydew_server.actions;

import android.os.RemoteException;
import com.amplify.honeydew_server.*;
import com.android.uiautomator.core.*;

import java.util.Map;

public class Sleep extends Action {
    public Sleep(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        try {
            getUiDevice().sleep();
        } catch (RemoteException e) {
            return Result.FAILURE;
        }
        return Result.OK;
    }
}
