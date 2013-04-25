package com.uiautomator_cucumber.android_server;

import android.util.Log;
import com.android.uiautomator.core.UiDevice;
import com.uiautomator_cucumber.android_server.actions.*;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Set;

import static com.google.common.collect.Sets.newHashSet;

public class ActionsExecutor {

    private final UiDevice uiDevice;
    private final HashMap<String, Action> actions;

    public ActionsExecutor(UiDevice uiDevice) throws IllegalAccessException, InstantiationException, InvocationTargetException, NoSuchMethodException {
        this.uiDevice = uiDevice;
        actions = new HashMap();
        for (Class<? extends Action> actionClass : allActionClasses()) {
            Constructor<? extends Action> constructor = actionClass.getConstructor(UiDevice.class);
            Action action = constructor.newInstance(getUiDevice());
            Log.d(getClass().getName(), String.format("Registering action: %s", action.name()));
            actions.put(action.name(), action);
        }
    }

    public Result execute(Command command) {
        String actionName = command.getAction();
        try {
            Action action = actions.get(actionName);
            if (action == null) {
                return new Result("Action: " + actionName + " does not exists");
            }
            return action.execute(command.getArguments());
        } catch (Exception e) {
            return new Result("Exception, on calling " + actionName, e);
        }
    }

    private static Set<Class<? extends Action>> allActionClasses() {
        Set<Class<? extends Action>> actionClasses = newHashSet();
        actionClasses.add(LaunchApp.class);
        actionClasses.add(LaunchHome.class);
        actionClasses.add(PressBack.class);
        actionClasses.add(IsTextPresent.class);
        actionClasses.add(IsButtonPresent.class);
        actionClasses.add(Click.class);
        actionClasses.add(ClickAndWaitForNewWindow.class);
        actionClasses.add(LongClick.class);
        actionClasses.add(SetText.class);
        actionClasses.add(SetTextByLabel.class);
        actionClasses.add(SetTextByIndex.class);
        actionClasses.add(DumpWindowHierarchy.class);
        actionClasses.add(SelectMenuInSettings.class);
        actionClasses.add(SelectFromAppsList.class);
        actionClasses.add(Unlock.class);
        return actionClasses;
    }

    private UiDevice getUiDevice() {
        return uiDevice;
    }
}
