import 'package:get_it/get_it.dart';
import 'package:random_user/services/ApiService.dart';

GetIt sl = GetIt.instance;

setupServiceLocator() {
  sl.registerSingleton<ApiService>(ApiService());
}
