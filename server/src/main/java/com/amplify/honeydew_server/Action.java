package com.amplify.honeydew_server;

import android.util.Log;
import com.android.uiautomator.core.UiDevice;
import com.android.uiautomator.core.UiObject;
import com.android.uiautomator.core.UiObjectNotFoundException;
import com.android.uiautomator.core.UiSelector;
import com.google.common.base.CaseFormat;

import java.util.Map;

public abstract class Action {
    protected final UiDevice uiDevice;

    public Action(UiDevice uiDevice) {
        this.uiDevice = uiDevice;
    }

    public abstract Result execute(Map<String, Object> arguments) throws UiObjectNotFoundException;

    public String name() {
        return CaseFormat.UPPER_CAMEL.to(CaseFormat.LOWER_UNDERSCORE, getClass().getSimpleName());
    }

    protected UiDevice getUiDevice() {
        return uiDevice;
    }

    protected UiObject getUiObject(Map<String, Object> arguments) {
        ViewSelector viewSelector = new ViewSelector();

        Log.d(getClass().getName(), arguments.toString());
        if (arguments.containsKey("type")) {
            Log.d(getClass().getName(), String.format("Type %s", (String) arguments.get("type")));
            viewSelector.withType((String) arguments.get("type"));
        }
        if (arguments.containsKey("text")) {
            Log.d(getClass().getName(), String.format("Text %s", (String) arguments.get("text")));
            viewSelector.withText((String) arguments.get("text"));
        }
        if (arguments.containsKey("description")) {
            Log.d(getClass().getName(), String.format("Description %s", (String) arguments.get("description")));
            viewSelector.withDescription((String) arguments.get("description"));
        }
        return viewSelector.find();
    }

    public static class ViewSelector {
        private UiSelector uiSelector = new UiSelector();

        public ViewSelector withType(String type) {
            uiSelector = uiSelector.className("android.widget." + type);
            return this;
        }

        public ViewSelector withText(String text) {
            uiSelector = uiSelector.textContains(text);
            return this;
        }

        public ViewSelector withDescription(String description) {
            uiSelector = uiSelector.description(description);
            return this;
        }

        public UiObject find() {
            return new UiObject(uiSelector);
        }
    }
}
