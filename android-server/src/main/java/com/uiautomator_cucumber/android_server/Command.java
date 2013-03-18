package com.uiautomator_cucumber.android_server;

import java.util.Map;

public class Command {
    private String action;
    private Map<String, Object> arguments;

    public String getAction() {
        return action;
    }

    public Map<String, Object> getArguments() {
        return arguments;
    }
}
