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
import java.util.HashMap;
import java.util.Map;

public class RemoteCommandReceiver extends NanoHTTPD {

    private static final String PLAIN_TEXT = "plain/text";
    private final ActionsExecutor actionsExecutor;

    private final Response statusOkResponse = new Response("honeydew-server is awaiting commands");
    private final Response terminateOkResponse = new Response("honeydew-server is stopping");
    private final Response badRequestResponse = new Response(Response.Status.BAD_REQUEST, PLAIN_TEXT, "Unsupported command");

    private final Gson jsonParser = new Gson();

    public RemoteCommandReceiver(ActionsExecutor actionsExecutor) throws IOException, InterruptedException {
        super(7120);
        this.actionsExecutor = actionsExecutor;
    }

    @Override
    public Response serve(String uri, Method method, Map<String, String> headers, Map<String, String> params, Map<String, String> files) {
        if (method == Method.POST && uri.equalsIgnoreCase("/terminate")) {
            stop();
            return terminateOkResponse;
        } else if (method == Method.POST && uri.equalsIgnoreCase("/command")) {
            return performCommand(params);
        } else if (method == Method.GET && uri.equalsIgnoreCase("/status")) {
            return statusOkResponse;
        }

        return badRequestResponse;
    }

    private Response performCommand(Map<String, String> params) {
        String action = params.get("action");
        String argumentJson = params.get("arguments");
        Type argumentCollectionType = new TypeToken<Map<String, Object>>(){}.getType();
        Map<String, Object> arguments = jsonParser.fromJson(argumentJson, argumentCollectionType);

        Log.i(getClass().getName(), String.format("Performing action %s: %s for %s", action, argumentJson, params.toString()));
        try {
            Result result = actionsExecutor.execute(new Command(action, arguments));
            if (result.success) {
                return new Response(result.description);
            } else {
                // TODO: NanoHTTPD does not provide a particularly complete set of status codes, so use 416 for now
                return new Response(Response.Status.RANGE_NOT_SATISFIABLE, PLAIN_TEXT, result.errorMessage);
            }
        } catch(Exception exception) {
            Log.e(getClass().getName(), String.format("Server error while processing command %s: %s", action, exception.toString()));
            return new Response(Response.Status.INTERNAL_ERROR, PLAIN_TEXT, exception.getMessage());
        }
    }
}