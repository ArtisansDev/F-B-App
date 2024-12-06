package com.rms.rms_mobile_xdk_flutter;

import androidx.annotation.NonNull;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.molpay.molpayxdk.MOLPayActivity;
import com.molpay.molpayxdk.googlepay.ActivityGP;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import java.lang.reflect.Field;
import java.util.Calendar;
import java.util.HashMap;


/** RmsMobileXdkFlutterPlugin */
public class RmsMobileXdkFlutterPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Activity activity;
  private Result results;
  private ActivityPluginBinding binding;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "fiuu_mobile_xdk_flutter");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if (call.method.equals("startXDK")) {
      startXDK(call, result);
    } else if (call.method.equals("startGooglePay")) {
      startGooglePay(call, result);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
    // TODO: your plugin is now attached to an Activity
    this.activity = activityPluginBinding.getActivity();
    binding = activityPluginBinding;
    binding.addActivityResultListener(this);
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {

  }

  @Override
  public void onDetachedFromActivity() {
    binding.removeActivityResultListener(this);
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
    if (requestCode == MOLPayActivity.MOLPayXDK && data != null) {
      if (data.getStringExtra(MOLPayActivity.MOLPayTransactionResult) != null) {
        this.results.success(data.getStringExtra(MOLPayActivity.MOLPayTransactionResult));
      }
    } else if (requestCode == MOLPayActivity.MOLPayXDK && resultCode == Activity.RESULT_CANCELED && data == null) {
      this.results.success("null");
    }
    return true;
  }


  private void startXDK(MethodCall call, Result result) {
    Field[] fields = MOLPayActivity.class.getDeclaredFields();
    HashMap<String, Object> paymentDetails = new HashMap<>();
    paymentDetails.put("is_submodule", true);
    paymentDetails.put("module_id", "molpay-mobile-xdk-flutter-beta-android");
    paymentDetails.put("wrapper_version", "15f");
    paymentDetails.put("mp_credit_card_no", call.argument(""));
    paymentDetails.put("mp_credit_card_expiry", call.argument(""));
    paymentDetails.put("mp_credit_card_cvv", call.argument(""));

    if (call.argument("mp_credit_card_no") != null) {
      paymentDetails.put("mp_credit_card_no", call.argument("mp_credit_card_no"));
    }
    if (call.argument("mp_credit_card_expiry") != null) {
      paymentDetails.put("mp_credit_card_expiry", call.argument("mp_credit_card_expiry"));
    }
    if (call.argument("mp_credit_card_cvv") != null) {
      paymentDetails.put("mp_credit_card_cvv", call.argument("mp_credit_card_cvv"));
    }

    if (call.argument("mp_metadata") != null) {
      paymentDetails.put("mp_metadata", call.argument("mp_metadata"));
    }

    for (Field f : fields) {
      if (call.argument(f.getName()) != null) {
        paymentDetails.put(f.getName(), call.argument(f.getName()));
      }
    }

    Intent intent = new Intent(activity, MOLPayActivity.class);
    intent.putExtra(MOLPayActivity.MOLPayPaymentDetails, paymentDetails);
    activity.startActivityForResult(intent, MOLPayActivity.MOLPayXDK);
    this.results = result;
  }

  private void startGooglePay(MethodCall call, Result result) {

    HashMap<String, Object> paymentDetails = new HashMap<>();

    paymentDetails.put(MOLPayActivity.mp_sandbox_mode, call.argument("mp_sandbox_mode"));
    paymentDetails.put(MOLPayActivity.mp_merchant_ID, call.argument("mp_merchant_ID"));
    paymentDetails.put(MOLPayActivity.mp_verification_key, call.argument("mp_verification_key"));
    paymentDetails.put(MOLPayActivity.mp_amount, call.argument("mp_amount"));
    paymentDetails.put(MOLPayActivity.mp_order_ID, call.argument("mp_order_ID"));
    paymentDetails.put(MOLPayActivity.mp_currency, call.argument("mp_currency"));
    paymentDetails.put(MOLPayActivity.mp_country, call.argument("mp_country"));
    paymentDetails.put(MOLPayActivity.mp_bill_description, call.argument("mp_bill_description"));
    paymentDetails.put(MOLPayActivity.mp_bill_name, call.argument("mp_bill_name"));
    paymentDetails.put(MOLPayActivity.mp_bill_email, call.argument("mp_bill_email"));
    paymentDetails.put(MOLPayActivity.mp_bill_mobile, call.argument("mp_bill_mobile"));

    if (call.argument("mp_extended_vcode") != null) {
      paymentDetails.put(MOLPayActivity.mp_extended_vcode, call.argument("mp_extended_vcode"));
    } else {
      paymentDetails.put(MOLPayActivity.mp_extended_vcode, false);
    }

    Intent intent = new Intent(activity, ActivityGP.class);
    intent.putExtra(MOLPayActivity.MOLPayPaymentDetails, paymentDetails);
    activity.startActivityForResult(intent, MOLPayActivity.MOLPayXDK);
    this.results = result;
  }

}
