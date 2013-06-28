package com.amplify.honeydew;

import org.apache.commons.lang.exception.ExceptionUtils;

public class Result {
    private final boolean success;
    private String description;
    private String errorMessage;
    private String stackTrace;

    public static Result OK = new Result();
    public static Result FAILURE = new Result(false);

    public Result() {
        this.success = true;
    }

    public Result(boolean success) {
        this.success = success;
    }

    public Result(boolean success, String description) {
        this.success = success;
        this.description = description;
    }

    public Result(String errorMessage, Throwable exception) {
        this(errorMessage);
        this.stackTrace = ExceptionUtils.getFullStackTrace(exception);
    }

    public Result(String errorMessage) {
        this.success = false;
        this.errorMessage = errorMessage;
    }
}
