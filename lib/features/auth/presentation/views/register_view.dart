import 'package:chat_app/core/utils/constants.dart';

import 'package:chat_app/features/auth/presentation/views/widgets/register_view_body.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(Constants.kAppName),
      ),
      body: const RegisterViewBody(),
    );
  }
}
