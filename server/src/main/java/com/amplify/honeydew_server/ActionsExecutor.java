package com.amplify.honeydew_server;

import android.util.Log;
import com.amplify.honeydew_server.actions.*;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.google.common.base.Stopwatch;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;
import java.util.Set;

import static com.google.common.collect.Maps.newHashMap;
import static com.google.common.collect.Sets.newHashSet;
import static java.util.concurrent.TimeUnit.MILLISECONDS;

public class ActionsExecutor {

    protected final UiDevice uiDevice;
    private final Map<String, Action> actions;
    private static final String TAG = ActionsExecutor.class.getName();

    public ActionsExecutor(UiDevice uiDevice) throws IllegalAccessException, InstantiationException, InvocationTargetException, NoSuchMethodException {
        this.uiDevice = uiDevice;
        actions = newHashMap();
        for (Class<? extends Action> actionClass : allActionClasses()) {
            Constructor<? extends Action> constructor = actionClass.getConstructor(UiDevice.class);
            Action action = constructor.newInstance(this.uiDevice);
            Log.d(TAG, String.format("Registering action: %s", action.name()));
            actions.put(action.name(), action);
        }
    }

    public Result execute(Command command) {
        String actionName = command.getAction();
        try {
            Action action = actions.get(actionName);
            if (action == null) {
                return new Result("Action: " + actionName + " does not exist");
            }
            return executeWithStopwatch(command, action);
        } catch (Exception e) {
            return new Result("Exception, on calling " + actionName, e);
        }
    }

    private Result executeWithStopwatch(Command command, Action action) throws UiObjectNotFoundException {
        Stopwatch timer = new Stopwatch().start();

        Result result = action.execute(command.getArguments());

        timer.stop();
        Log.i(TAG, String.format("action '%s' took %d ms to execute on the tablet",
                command.getAction(), timer.elapsed(MILLISECONDS)));
        return result;
    }

    private static Set<Class<? extends Action>> allActionClasses() {
        Set<Class<? extends Action>> actionClasses = newHashSet();
        actionClasses.add(LaunchApp.class);
        actionClasses.add(LaunchHome.class);
        actionClasses.add(PressBack.class);
        actionClasses.add(PressEnter.class);
        actionClasses.add(WakeUp.class);
        actionClasses.add(Sleep.class);
        actionClasses.add(IsTextPresent.class);
        actionClasses.add(IsTextGone.class);
        actionClasses.add(IsButtonPresent.class);
        actionClasses.add(IsElementWithNestedTextPresent.class);
        actionClasses.add(IsChildCountEqualTo.class);
        actionClasses.add(IsChildCountGreaterThan.class);
        actionClasses.add(Click.class);
        actionClasses.add(ClickAndWaitForNewWindow.class);
        actionClasses.add(LongClick.class);
        actionClasses.add(SetText.class);
        actionClasses.add(SetTextByLabel.class);
        actionClasses.add(SetTextByIndex.class);
        actionClasses.add(DumpWindowHierarchy.class);
        actionClasses.add(SelectMenuInSettings.class);
        actionClasses.add(IsOptionInSettingsMenuEnabled.class);
        actionClasses.add(IsOptionInSettingsMenuDisabled.class);
        actionClasses.add(HasSettingsMenuItem.class);
        actionClasses.add(SelectFromAppsList.class);
        actionClasses.add(Unlock.class);
        actionClasses.add(ScrollToTextByIndex.class);
        return actionClasses;
    }
}
