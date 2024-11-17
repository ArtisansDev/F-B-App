import '../../web_response.dart';

mixin OrderHistoryApi {
  Future<WebResponseSuccess> postOrderPlace(dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetOrderHistory(dynamic exhibitorsListRequest);
}
