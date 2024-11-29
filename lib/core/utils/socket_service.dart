import 'dart:developer';

import 'package:chat_app/core/utils/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  // static final instance = SocketService();
  static io.Socket? socket;
  static init() {
    socket = io.io(
      Constants.kBaseUrl,
      io.OptionBuilder().setTransports(['websocket']).build(),
    );
    socket!.connect();
    socket!.onConnect((handler) {
      log("socket connect");
    });
  }
}
