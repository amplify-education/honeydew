package com.amplify.honeydew_server.actions;

import com.android.uiautomator.core.*;
import com.amplify.honeydew_server.Action;
import com.amplify.honeydew_server.Result;
import android.os.RemoteException;

import java.util.Map;

public class WakeUp extends Action {
    public WakeUp(UiDevice uiDevice) {
        super(uiDevice);
    }

    @Override
    public Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException {
        try {
            getUiDevice().wakeUp();
        } catch (RemoteException e) {
            return Result.FAILURE;
        }
        return Result.OK;
    }
}
