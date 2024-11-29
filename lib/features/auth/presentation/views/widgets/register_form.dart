import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/core/utils/functions/snak_bar.dart';
import 'package:chat_app/features/auth/data/models/user_response/response_user.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/views/login_view.dart';
import 'package:chat_app/core/widgets/custom_bottun.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/form_item.dart';
import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:chat_app/features/home/presentation/views/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassswordController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPassswordController.dispose();
    super.dispose();
  }

  _navigateToHome({
    required String token,
  }) {
    if (mounted) {
      showSnackBar(
        context,
        message: "succesfuly Sign Up",
        color: Colors.green,
      );
      BlocProvider.of<HomeCubit>(context).getUserData(token: token);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormItem(
            nameController: nameController,
            name: "Name",
            hintText: "Enter your name",
          ),
          const SizedBox(
            height: 16,
          ),
          FormItem(
            nameController: emailController,
            keyboardType: TextInputType.emailAddress,
            name: "Email Address",
            hintText: "Enter your Email",
          ),
          const SizedBox(
            height: 16,
          ),
          FormItem(
            nameController: passwordController,
            name: "Password",
            hintText: "Enter your password",
          ),
          const SizedBox(
            height: 16,
          ),
          FormItem(
            nameController: confirmPassswordController,
            name: "Confirm Password",
            hintText: "Confirm your password",
          ),
          const SizedBox(
            height: 36,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is SignUpSuccessState) {
                await Hive.box<UserResponse>(Constants.kUserHiveKey)
                    .add(state.userModel);

                _navigateToHome(
                  token: state.token,
                );
              }
              if (state is SignUpFailuretate) {
                showSnackBar(
                  context,
                  message: state.error,
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              bool isLoading = false;
              if (state is SignUpLoadingState) {
                isLoading = true;
              }
              return CustomButton(
                isLoading: isLoading,
                text: "Sign Up",
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (BlocProvider.of<AuthCubit>(context).profileImage ==
                        null) {
                      showSnackBar(
                        context,
                        message: "you must pick an image",
                        color: Colors.redAccent,
                      );
                    } else {
                      BlocProvider.of<AuthCubit>(context).signup(
                        confirmPassword: confirmPassswordController.text,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    }
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginView()));
            },
            text: "Log in",
            color: Colors.white,
            textColor: Constants.kPrimaryColor,
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
