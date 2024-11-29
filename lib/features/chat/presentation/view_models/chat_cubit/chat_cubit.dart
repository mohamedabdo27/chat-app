import 'dart:developer';

import 'package:chat_app/core/utils/socket_service.dart';
import 'package:chat_app/features/chat/data/models/messages.dart';

import 'package:chat_app/features/chat/data/services/chat_service.dart';
import 'package:chat_app/features/chat/presentation/view_models/chat_cubit/chat_state.dart';
import 'package:chat_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatService) : super(InitialChatState());
  final ChatService chatService;

  sendMessage({
    required String message,
    required String reseverId,
  }) async {
    try {
      if (!isClosed) emit(SendMessageLoadingState());
      await chatService.sendMessage(
        message: message,
        reseverId: reseverId,
        token: userResponse!.token!,
      );

      if (!isClosed) emit(SendMessageSuccessState());
    } on DioException catch (e) {
      emit(SendMessageFailureState(error: e.toString()));
    }
  }

  List<Messages> messages = [];

  getMessages({
    required String reseiverId,
  }) async {
    if (!isClosed) emit(GetMessagesLoadingState());

    try {
      Response response = await chatService.getMessages(
        reseiverId: reseiverId,
        token: userResponse!.token!,
      );

      MessagesResponse messagesResponse =
          MessagesResponse.fromJson(response.data);

      messages = messagesResponse.messages!;
      if (!isClosed) emit(GetMessagesSuccessState());
    } on DioException catch (e) {
      if (!isClosed) emit(GetMessagesFailureState(error: "there was an error"));
      log(e.toString());
    }
  }

  updateChatMessages({
    required String freindId,
  }) {
    final Socket? socket = SocketService.socket;
    Messages? message;
    socket!.on("send", (data) {
      message = Messages.fromJson(data["message"]);

      if (userResponse!.user!.sId == message!.senderId &&
              freindId == message!.receiverId ||
          userResponse!.user!.sId == message!.receiverId &&
              freindId == message!.senderId) {
        messages.insert(0, message!);
        if (!isClosed) emit(SocketChatState());
      }
    });
  }
}
