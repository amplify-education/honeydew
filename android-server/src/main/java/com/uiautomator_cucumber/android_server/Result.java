package com.uiautomator_cucumber.android_server;

import org.apache.commons.lang.exception.ExceptionUtils;

public class Result {
    private final boolean success;
    private String errorMessage;
    private String stackTrace;

    public static Result OK = new Result();
    public static Result FAILURE = new Result(false);

    public Result() {
        this.success = true;
    }

    public Result(String errorMessage, Throwable exception) {
        this(errorMessage);
        this.stackTrace = ExceptionUtils.getFullStackTrace(exception);
    }

    public Result(String errorMessage) {
        this.success = false;
        this.errorMessage = errorMessage;
    }

    public Result(boolean success) {
        this.success = success;
    }
}
