import 'dart:developer';

import 'package:chat_app/core/utils/socket_service.dart';
import 'package:chat_app/features/home/data/Services/home_service.dart';
import 'package:chat_app/features/home/data/models/users_data/users_data.dart';
import 'package:chat_app/features/home/data/models/users_data/users_with_last_msg.dart';
import 'package:chat_app/features/home/presentation/view_models/home_cubit/home_state.dart';
import 'package:chat_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService homeService;

  HomeCubit(this.homeService) : super(InitiallHomeState());

  UsersData? usersData;

  getUserData({required String token}) async {
    emit(GetUserLoadingState());

    try {
      Response response = await homeService.getUserData(token: token);
      usersData = UsersData.fromJson(response.data);
      emit(GetUserSuccessState());
    } catch (e) {
      emit(GetUserFailureState(error: e.toString()));
      log(e.toString());
    }
  }

  updateUsers() {
    final socket = SocketService.socket;
    UsersWithLastMsg message;
    socket!.on("send", (data) {
      message = UsersWithLastMsg.fromJson(data["message"]);

      if (message.receiverId == userResponse!.user!.sId ||
          message.senderId == userResponse!.user!.sId) {
        int currentIndex = usersData!.users!.indexWhere(
          (element) {
            return element.id == message.receiverId ||
                element.id == message.senderId;
          },
        );
        if (currentIndex != -1) {
          var tempUser = usersData!.users![currentIndex];

          tempUser.usersWithLastMsg = message;

          usersData!.users!.removeAt(currentIndex);

          usersData!.users!.insert(0, tempUser);

          emit(UpdateUsersState());
        }
      }
    });
  }
}
