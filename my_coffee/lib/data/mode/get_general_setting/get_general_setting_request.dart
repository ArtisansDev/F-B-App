/*
 * Project      : my_coffee
 * File         : get_general_setting_request.dart
 * Description  : 
 * Author       : parthapaul
 * Date         : 2024-11-14
 * Version      : 1.0
 * Ticket       : 
 */

import 'package:flutter_dotenv/flutter_dotenv.dart';

class GetGeneralSettingRequest {
  GetGeneralSettingRequest();

  GetGeneralSettingRequest.fromJson(dynamic json) {
    accessKey = json['AccessKey'];
  }

  String accessKey = (dotenv.env['AccessKey'] == '1'
      ? dotenv.env['Thomson_Corner']
      : dotenv.env['AccessKey'] == '2'
          ? dotenv.env['Apple_Cinemas']
          : dotenv.env['TWT'])??'';

  Map<String, String> toJson() {
    final map = <String, String>{};
    map['AccessKey'] = accessKey;
    return map;
  }
}
