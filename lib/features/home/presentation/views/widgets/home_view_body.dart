import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_state.dart';
import 'package:chat_app/features/home/presentation/views/widgets/contact_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Your Cantact",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is GetUserLoadingState) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (state is GetUserFailureState) {
                return const Expanded(
                    child: Center(child: Text("there was an error")));
              }
              return const ContactListView();
            },
          ),
        ],
      ),
    );
  }
}
