import '../../web_response.dart';

mixin GeneralApi {
  Future<WebResponseSuccess> postGeneralSetting();
  Future<WebResponseSuccess> postGetBestSellerItem(
      dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetDashboard(
      dynamic exhibitorsListRequest);
}
