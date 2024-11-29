import 'package:chat_app/core/utils/constants.dart';
import 'package:chat_app/core/utils/functions/snak_bar.dart';
import 'package:chat_app/features/auth/data/models/user_response/response_user.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/views/register_view.dart';
import 'package:chat_app/core/widgets/custom_bottun.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/form_item.dart';
import 'package:chat_app/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormBodyState();
}

class _LoginFormBodyState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showMessage({required String message, Color? color}) {
    if (mounted) {
      showSnackBar(
        context,
        message: message,
        color: color,
      );
    }
  }

  _navigateToHome({required String token}) {
    if (mounted) {
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
            height: 36,
          ),
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) async {
              if (state is LoginSuccessState) {
                _showMessage(
                  message: "succesfuly login",
                  color: Colors.green,
                );

                await Hive.box<UserResponse>(Constants.kUserHiveKey).add(
                  state.userModel,
                );

                _navigateToHome(token: state.token);
              }
              if (state is LoginFailuretate) {
                _showMessage(
                  message: state.error,
                  color: Colors.red,
                );
              }
            },
            builder: (context, state) {
              bool isLoading = false;
              if (state is LoginLoadingState) {
                isLoading = true;
              }
              return CustomButton(
                isLoading: isLoading,
                text: "Log In",
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<AuthCubit>(context).login(
                      password: passwordController.text,
                      email: emailController.text,
                    );
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Don’t have an account ?",
            style: TextStyle(fontSize: 16),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterView(),
                ),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: Constants.kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
