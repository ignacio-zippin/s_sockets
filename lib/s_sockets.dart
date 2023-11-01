import 'package:socket_io_client/socket_io_client.dart' as io;

class SSockets {
  static final SSockets _instance = SSockets._constructor();
  factory SSockets() {
    return _instance;
  }
  SSockets._constructor();

  late io.Socket _socket;

  void init(String url, {Function? onConnect}) {
    _socket = io.io(
        url,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    _socket.connect();
    _socket.onConnect((_) {
      onConnect?.call();
    });
  }

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void on(String event, dynamic Function(dynamic) handler) {
    _socket.on(event, handler);
  }
}
