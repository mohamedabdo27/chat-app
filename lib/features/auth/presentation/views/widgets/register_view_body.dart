import 'package:chat_app/core/utils/functions/snak_bar.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/presentation/view_models/auth_cubit/auth_state.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/pick_profile_image.dart';
import 'package:chat_app/features/auth/presentation/views/widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Create a free account".toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "AI tools, designed to enhance your game, optimize your score, and dominate your mini-leagues."
                  .toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xff242424),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is PickProfileImageFailuretate) {
                  showSnackBar(context,
                      message: state.error, color: Colors.red);
                }
              },
              builder: (context, state) {
                return PickProfileImage(
                    image: BlocProvider.of<AuthCubit>(context).profileImage);
              },
            ),
            const RegisterForm(),
          ],
        ),
      ),
    );
  }
}
