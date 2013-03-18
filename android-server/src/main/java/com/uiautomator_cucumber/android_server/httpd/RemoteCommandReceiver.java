package com.uiautomator_cucumber.android_server.httpd;

import android.util.Log;
import com.google.gson.Gson;
import com.uiautomator_cucumber.android_server.ActionsExecutor;
import com.uiautomator_cucumber.android_server.Command;
import com.uiautomator_cucumber.android_server.Result;

import java.io.File;
import java.io.IOException;
import java.util.Properties;

public class RemoteCommandReceiver extends NanoHTTPD {
    private static final String MIME_JSON = "application/json";
    private static final String TAG = "RemoteCommandReceiver";
    private final Gson gson;
    private final ActionsExecutor actionsExecutor;
    private boolean running = true;

    public RemoteCommandReceiver(ActionsExecutor actionsExecutor) throws IOException, InterruptedException {
        super(9090, new File("/"));
        Log.d(TAG, "Listening on HTTP port 9090. Kill test to stop");
        this.gson = new Gson();
        this.actionsExecutor = actionsExecutor;
        while (running) {
            Thread.sleep(5000);
        }
    }

    @Override
    public Response serve(String uri, String method, Properties header, Properties params, Properties files) {
        log(uri, method, params);

        Result result = tryPerformingControlAction(method, uri);
        if (result == null) {
            result = performActionOnDevice(params);
        }
        return new Response(HTTP_OK, MIME_JSON, gson.toJson(result));
    }

    @Override
    public void stop() {
        super.stop();
        this.running = false;
    }

    private Result performActionOnDevice(Properties params) {
        return actionsExecutor.execute(gson.fromJson((String) params.get("command"), Command.class));
    }

    private Result tryPerformingControlAction(String method, String uri) {
        if (uri.equalsIgnoreCase("/terminate")) {
            stop();
            return Result.OK;
        } else if(method.equalsIgnoreCase("HEAD")) {
            return Result.OK;
        }
        return null;
    }

    private void log(String uri, String method, Properties params) {
        Log.d(TAG, String.format("Processing uri: %s, method: %s, params: %s", uri, method, params));
    }
}