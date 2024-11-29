abstract class ChatState {}

class InitialChatState extends ChatState {}

class SendMessageSuccessState extends ChatState {}

class SendMessageFailureState extends ChatState {
  final String error;

  SendMessageFailureState({required this.error});
}

class SendMessageLoadingState extends ChatState {}

class GetMessagesSuccessState extends ChatState {}

class GetMessagesFailureState extends ChatState {
  final String error;

  GetMessagesFailureState({required this.error});
}

class GetMessagesLoadingState extends ChatState {}

class SocketChatState extends ChatState {}

class ExpandTextChatState extends ChatState {}
