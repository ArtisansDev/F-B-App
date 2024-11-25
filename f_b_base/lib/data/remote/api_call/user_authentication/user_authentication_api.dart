

import '../../../mode/profile_image/profile_image_update_request.dart';
import '../../web_response.dart';

mixin UserAuthenticationApi {
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postVerifyOTP(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postRegister(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetUserData(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUserDetailsUpdate(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUserAddressUpdate(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUserDelete(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postProfileImageFile(String filePart,
      ProfileImageUpdateRequest mProfileImageUpdateRequest);
}
