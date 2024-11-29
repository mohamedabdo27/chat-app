import 'package:chat_app/core/utils/constants.dart';

import 'package:chat_app/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(Constants.kAppName),
        centerTitle: true,
      ),
      body: const LoginViewBody(),
    );
  }
}
