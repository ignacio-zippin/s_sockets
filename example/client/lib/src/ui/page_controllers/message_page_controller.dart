// Package imports:
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:s_sockets/s_sockets.dart';

// Project imports:
import '../../interfaces/i_view_controller.dart';
import '../../utils/page_args.dart';

class MessagePageController extends ControllerMVC implements IViewController {
  static late MessagePageController _this;

  factory MessagePageController() {
    _this = MessagePageController._();
    return _this;
  }

  static MessagePageController get con => _this;
  PageArgs? args;
  MessagePageController._();

  TextEditingController controller = TextEditingController();
  bool isConnected = true;
  final messageStreamController = StreamController<String>.broadcast();

  @override
  void initPage({PageArgs? arguments}) {}

  @override
  disposePage() {}

  void sendMessage() {
    if (controller.text.isNotEmpty && isConnected) {
      SSockets().emit('message', '{"message": "${controller.text}"}');
    }
  }

  Stream<String> recivedMessage() {
    if (isConnected) {
      SSockets().on('recieveMessage', (data) {
        final message = jsonDecode(data);
        messageStreamController.add(message['message']);
      });
    }

    return messageStreamController.stream;
  }
}
