package com.amplify.honeydew_server.httpd;

import android.util.Log;
import com.amplify.honeydew_server.ActionsExecutor;
import com.amplify.honeydew_server.Command;
import com.amplify.honeydew_server.Result;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import fi.iki.elonen.NanoHTTPD;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.Map;

import static java.lang.String.format;

public class RemoteCommandReceiver extends NanoHTTPD {

    private static final String PLAIN_TEXT = "plain/text";
    public static final Type ARGUMENTS_COLLECTION_TYPE = new TypeToken<Map<String, Object>>() {
    }.getType();
    private final ActionsExecutor actionsExecutor;

    private static final Response OK = new Response("honeydew-server is awaiting commands");
    private static final Response TERMINATED = new Response("honeydew-server is stopping");
    private final Response BAD_REQUEST = new Response(Response.Status.BAD_REQUEST, PLAIN_TEXT, "Unsupported command");

    private static final String TAG = RemoteCommandReceiver.class.getSimpleName();
    private final Gson jsonParser = new Gson();

    public RemoteCommandReceiver(ActionsExecutor actionsExecutor) throws IOException, InterruptedException {
        super(7120);
        this.actionsExecutor = actionsExecutor;
    }

    @Override
    public Response serve(String uri, Method method, Map<String, String> headers, Map<String, String> params, Map<String, String> files) {
        if (method == Method.POST && uri.equalsIgnoreCase("/terminate")) {
            return terminate();
        }
        if (method == Method.POST && uri.equalsIgnoreCase("/command")) {
            return performCommand(params);
        }
        if (method == Method.GET && uri.equalsIgnoreCase("/status")) {
            return status();
        }

        return BAD_REQUEST;
    }

    private Response status() {
        Log.d(TAG, "Got status request, responding OK");
        return OK;
    }

    private Response terminate() {
        Log.d(TAG, "Got terminate request, finishing up...");
        stop();
        return TERMINATED;
    }

    private Response performCommand(Map<String, String> params) {
        String action = params.get("action");
        String argumentJson = params.get("arguments");
        Map<String, Object> arguments = jsonParser.fromJson(argumentJson, ARGUMENTS_COLLECTION_TYPE);

        Log.i(TAG, format("Performing action %s: %s for %s", action, argumentJson, params.toString()));
        try {
            Result result = actionsExecutor.execute(new Command(action, arguments));
            if (result.success) {
                return new Response(result.description);
            }
            return new Response(Response.Status.NO_CONTENT, null, (String) null);
        } catch (Exception exception) {
            Log.e(TAG, format("Server error while processing command %s: %s", action, exception.toString()));
            return new Response(Response.Status.INTERNAL_ERROR, PLAIN_TEXT, exception.getMessage());
        }
    }
}
