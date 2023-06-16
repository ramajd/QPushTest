package io.github.ramajd.pushtest;

import org.qtproject.qt5.android.bindings.QtApplication;
import org.qtproject.qt5.android.bindings.QtActivity;

import android.util.Log;

import android.view.WindowManager;

import android.os.Bundle;
import android.os.Handler;
import android.content.Intent;
import com.google.firebase.messaging.MessageForwardingService;

public class MainActivity extends QtActivity {
    private static String TAG = "PUSH_TEST (ACTIVITY)";

    @Override
    public void onCreate(Bundle savedInstanceState) {
        Log.d(TAG, "onCreate called");
        super.onCreate(savedInstanceState);

//        Intent intent = getIntent();
//        Handler handler = new Handler();
//        handler.postDelayed(new Runnable() {
//            @Override
//            public void run() {
//                Log.d(TAG, "postDeleyed -> run");
//                checkIntent(intent);
//            }
//        }, 3000);
    }


    private static final String EXTRA_MESSAGE_ID_KEY_SERVER = "message_id";

    private static final String EXTRA_MESSAGE_ID_KEY = "google.message_id";

    private static final String EXTRA_FROM = "google.message_id";

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        checkIntent(intent);
    }

    protected void checkIntent(Intent intent) {
        Log.d(TAG, "checkIntent");
        Bundle extras = intent.getExtras();
        if (extras == null) {
            Log.d(TAG, "extras is NULL");
            return;
        }
        String from = extras.getString(EXTRA_FROM);
        String messageId = extras.getString(EXTRA_MESSAGE_ID_KEY);

        if (messageId == null) {
            messageId = extras.getString(EXTRA_MESSAGE_ID_KEY_SERVER);
        }

        if (from != null && messageId != null) {
            Intent message = new Intent(this, MessageForwardingService.class);
            message.setAction(MessageForwardingService.ACTION_REMOTE_INTENT);
            message.putExtras(intent);
            startService(message);
        }
        setIntent(intent);
    }

}
