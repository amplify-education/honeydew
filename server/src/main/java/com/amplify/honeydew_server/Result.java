package com.amplify.honeydew_server;

import org.apache.commons.lang.exception.ExceptionUtils;

public class Result {
    public final boolean success;
    public String description;
    public String errorMessage;
    public String stackTrace;

    public static Result OK = new Result();
    public static Result FAILURE = new Result(false);

    public Result() {
        this(true, "Success!");
    }

    public Result(boolean success) {
        this(success, success ? "Success!" : "Failure.");
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
