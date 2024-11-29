import 'dart:developer';

import 'package:chat_app/core/utils/bloc_observer.dart';
import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/core/utils/service_locator.dart';
import 'package:chat_app/core/utils/socket_service.dart';
import 'package:chat_app/features/auth/data/models/user_response/response_user.dart';
import 'package:chat_app/features/auth/data/models/user_response/user.dart';
import 'package:chat_app/features/auth/data/services/auth_service.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/views/register_view.dart';

import 'package:chat_app/features/home/data/Services/home_service.dart';
import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:chat_app/features/home/presentation/views/home_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

// String? token = "";
UserResponse? userResponse;
// String? userId = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SocketService.init();
  serviceLocatorSetup();

  await Hive.initFlutter();
  Hive.registerAdapter(UserResponseAdapter());
  Hive.registerAdapter(UserAdapter());
  bool isLogin = false;
  await Hive.openBox<UserResponse>(Constants.kUserHiveKey);
  var userBox = Hive.box<UserResponse>(Constants.kUserHiveKey);
  var users = userBox.values.toList();
  if (users.isNotEmpty) {
    log("logined");
    userResponse = users[0];
    isLogin = true;
  }

  // String? cachToken = CachData.getString(key: Constants.kTokenKey);
  // userId = CachData.getString(key: Constants.kUserIdKey);
  // if (cachToken != null) {
  //   // var userBox = Hive.box<User>(Constants.kUserHiveKey);
  //   // user = userBox.getAt(0);
  //   isLogin = true;
  //   token = cachToken;
  // }
  runApp(ChatApp(
    isLogin: isLogin,
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key, required this.isLogin});
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(getIt.get<AuthService>())),
        BlocProvider(
          create: (context) => HomeCubit(HomeService(dio: Dio()))
            // ..getUserData(token: userResponse!.token!)
            ..updateUsers(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          primaryColor: Constants.kPrimaryColor,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          brightness: Brightness.light,
          useMaterial3: true,
        ),
        home: isLogin ? const HomeView() : const RegisterView(),
      ),
    );
  }
}
