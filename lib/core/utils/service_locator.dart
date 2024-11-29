import 'package:chat_app/core/utils/api.dart';
import 'package:chat_app/features/auth/data/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
serviceLocatorSetup() {
  getIt.registerSingleton<Api>(Api(dio: Dio()));

  getIt.registerSingleton<AuthService>(AuthService(getIt.get<Api>()));
}
