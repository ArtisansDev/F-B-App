import '../../web_response.dart';

mixin OrderHistoryApi {
  Future<WebResponseSuccess> postOrderPlace(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetOrderHistory(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postPaymentType(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postUpdatePaymentStatus(dynamic exhibitorsListRequest);
}
