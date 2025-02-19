import '../../web_response.dart';

mixin ProductApi {

  Future<WebResponseSuccess> postGetAllBranchesByRestaurantID(
      dynamic exhibitorsListRequest,{bool isLoading = true});
  Future<WebResponseSuccess> postGetCategory(
      dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetSeatDetail(
      dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetCategoryItem(
      dynamic exhibitorsListRequest);
  Future<WebResponseSuccess> postGetItemDetails(
      dynamic exhibitorsListRequest,{bool isLoading = true});
}
