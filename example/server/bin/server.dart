import 'dart:developer';

import 'package:socket_io/socket_io.dart';

import 'models/message.dart';
import 'models/offset.dart';

void main(List<String> args) {
  var io = Server();
  io.on('connection', (client) {
    print('Client connected $client');

    // Messaging

    client.join('messageRoom');

    client.on('message', (data) {
      log(data);

      final message = Message.fromJson(data);

      io.to('messageRoom').emit('recieveMessage', message.toJson());
    });

    // Drawing

    client.join('canvasRoom');

    client.on('canvas', (data) {
      log(data);
      final offset = Offset.fromJson(data);

      io.to('canvasRoom').emit('draw', offset.toJson());
    });

    client.on('endLine', (data) {
      io.to('canvasRoom').emit('endLine', null);
    });

    client.on('clearCanvas', (data) {
      log(data);
      io.to('canvasRoom').emit('cleaningCanvas');
      io.to('canvasRoom').emit('endLine', null);
    });
  });
  io.listen(3000);
}
