import 'package:chat_app/features/home/data/models/users_data/users_data.dart';
import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_cubit.dart';
import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_state.dart';
import 'package:chat_app/features/home/presentation/views/widgets/contact_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    UsersData? usersData = BlocProvider.of<HomeCubit>(context).usersData;

    return Expanded(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetUserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetUserFailureState) {
            return const Center(child: Text("there was an error"));
          }
          return usersData!.users!.isEmpty
              ? const Center(
                  child: Text("there is not user"),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ContactItem(
                      user: usersData.users![index],
                    ),
                  ),
                  itemCount: usersData.users!.length,
                );
        },
      ),
    );
  }
}
