import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../constants/web_constants.dart';
import '../../local/shared_prefs/shared_prefs.dart';

class WebProvider extends GetConnect {
  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json"
  };

  Future<Response> getWithRequest(String action, dynamic params) async {
    debugPrint("queryRequest ==  $params");
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      headers.addAll({'Authorization': "Bearer ${tokenValue}"});
    }

    var mResponse = await get(action, decoder: jsonDecode(params));
    return mResponse;
  }

  Future<Response> getWithWithoutRequest(String action) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }
    debugPrint("getWithWithoutRequest ${WebConstants.baseUrlCommon}$action");
    Response mResponse =
        await get(WebConstants.baseUrlCommon + action, headers: headers);
    return mResponse;
  }

  @override
  Future<Response> postWithRequest(String action, params) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      headers.addAll({'Authorization': "Bearer $tokenValue"});
    }

    debugPrint("url ==  ${WebConstants.baseUrlCommon + action}");
    debugPrint("headers ==  ${jsonEncode(headers)}");
    debugPrint("plainJsonRequest ==  ${jsonEncode(params)}");

    allowAutoSignedCert = true;
    var mResponse = await post(
        WebConstants.baseUrlCommon + action, jsonEncode(params),
        headers: headers);
    debugPrint("mResponse statusCode ==  ${mResponse.statusCode}");
    debugPrint("mResponse ==  ${jsonEncode(mResponse.body)}");
    return mResponse;
  }

  @override
  Future<Response> postWithoutRequest(String action) async {
    if (WebConstants.auth) {
      String tokenValue = await SharedPrefs().getUserToken();
      headers.addAll({'Authorization': "Bearer ${tokenValue}"});
    }
    debugPrint("url ==  ${WebConstants.baseUrlCommon + action}");
    allowAutoSignedCert = true;
    var mResponse =
        await post(WebConstants.baseUrlCommon + action, "", headers: headers);
    return mResponse;
  }

  @override
  Future<Response> postWithRequestAndAttachment(
      String action, Map<String, dynamic> productMap,
      {String filePath = ""}) async {
    try {
      if (WebConstants.auth) {
        String tokenValue = await SharedPrefs().getUserToken();
        headers.addAll({'Authorization': "Bearer ${tokenValue}"});
      }
      String picName = filePath.split("/").last;
      debugPrint("pic name: - $picName");
      debugPrint("url name: - ${WebConstants.baseUrlCommon + action}");
      MultipartFile mMultipartFile = MultipartFile(File(filePath),
          filename: picName, contentType: "multipart/form-data");
      final form = FormData({
        'attachment': mMultipartFile,
        // 'id': '593'
      });

      allowAutoSignedCert = true;
      Response mResponse = await post(WebConstants.baseUrlCommon + action, form,
          headers: headers);
      return mResponse;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
