package com.uiautomator_cucumber.android_server.actions;

import com.android.uiautomator.core.*;
import com.uiautomator_cucumber.android_server.Action;
import com.uiautomator_cucumber.android_server.Result;
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