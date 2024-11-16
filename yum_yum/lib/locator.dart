import 'package:get_it/get_it.dart';

import 'data/local/database/counter/CounterLocalApi.dart';
import 'data/local/database/counter/CounterLocalApiImpl.dart';
import 'data/remote/api_call/api_adapter.dart';
import 'data/remote/api_call/api_impl.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// Local Database API
  // locator.registerLazySingleton<CounterLocalApi>(() => CounterLocalApiImpl());

  /// All Api Call
  locator.registerLazySingleton<IApiRepository>(() => AllApiImpl());
}
