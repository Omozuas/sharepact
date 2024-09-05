import 'package:sharepact_app/config.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketServices {
  late Socket socket;

  Future<void> connectIO(
      {required String token, required String userId}) async {
    socket = io(
        Config.baseUrl,
        OptionBuilder()
            .setTransports(["websocket"])
            .disableAutoConnect()
            .setExtraHeaders({"token": token})
            .build());
    socket.connect();
    socket.emit("chat-message", []);
    socket.emit("messages-$userId", []);
    socket.onConnect((data) {
      print('connected');
      socket.on("send-message", (msg) {
        print(msg);
      });
    });

    socket.onDisconnect((_) => print('disconnected'));
    print({'socket': socket.connected});
  }

  void sendMessage({String? message, String? roomId}) {
    if (socket.connected) {
      socket.emit('send-message', {'msg': message, 'room': roomId});
    }
  }
}
