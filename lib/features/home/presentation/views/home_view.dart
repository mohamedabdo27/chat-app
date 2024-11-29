import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/core/widgets/user_image.dart';
import 'package:chat_app/features/auth/data/models/user_response/response_user.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_cubit.dart';

import 'package:chat_app/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:chat_app/features/home/presentation/views/widgets/log_out_dialog.dart';
import 'package:chat_app/main.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    BlocProvider.of<HomeCubit>(context)
        .getUserData(token: userResponse!.token!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var name = userResponse!.user!.name!;
    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
      appBar: AppBar(
        title: const Text(Constants.kAppName),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    var width = MediaQuery.of(context).size.width;
                    return LogoutDialog(
                      width: width,
                      onTap: () async {
                        await _logOut();
                        _navigateToLoginView();
                      },
                    );
                  });
            },
            child: Row(
              children: [
                UserImage(
                  raduis: 16,
                  imageUrl: userResponse!.user!.imageUrl!,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name.length > 13 ? "${name.substring(0, 13)}.." : name,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ],
      ),
      body: const HomeViewBody(),
    );
  }

  Future<void> _logOut() async {
    var userBox = Hive.box<UserResponse>(Constants.kUserHiveKey);
    await userBox.clear();
  }

  void _navigateToLoginView() {
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(),
        ),
        (route) => false,
      );
    }
  }
}
