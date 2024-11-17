import '../../web_response.dart';

mixin GeneralApi {
  Future<WebResponseSuccess> getGeneralSetting();
  Future<WebResponseSuccess> postGetBestSellerItem(
      dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetDashboard(
      dynamic exhibitorsListRequest);
}
