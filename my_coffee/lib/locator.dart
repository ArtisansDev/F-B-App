import 'package:get_it/get_it.dart';

import 'data/remote/api_call/general_api/general_api.dart';
import 'data/remote/api_call/general_api/general_api_impl.dart';
import 'data/remote/api_call/order/order_api.dart';
import 'data/remote/api_call/order/order_api_impl.dart';
import 'data/remote/api_call/product_api/product_api.dart';
import 'data/remote/api_call/product_api/product_api_impl.dart';
import 'data/remote/api_call/user_authentication/user_authentication_api.dart';
import 'data/remote/api_call/user_authentication/user_authentication_api_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// Local Database API
  // locator.registerLazySingleton<CounterLocalApi>(() => CounterLocalApiImpl());

  /// All Api Call
  locator.registerLazySingleton<UserAuthenticationApi>(() => UserAuthenticationApiImpl());
  locator.registerLazySingleton<OrderHistoryApi>(() => OrderHistoryApiImpl());
  locator.registerLazySingleton<GeneralApi>(() => GeneralApiImpl());
  locator.registerLazySingleton<ProductApi>(() => ProductApiImpl());
}
