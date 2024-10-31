
import '../web_response.dart';

abstract class IApiRepository {
  Future<WebResponseSuccess> postLogin(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postVerifyOTP(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postRegister(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetUserData(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUserDetailsUpdate(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUserAddressUpdate(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUserDelete(dynamic exhibitorsListRequest);
}
