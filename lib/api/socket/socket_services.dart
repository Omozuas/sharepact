import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/chat_model.dart';
import 'package:sharepact_app/api/riverPod/chat2_provider.dart';
import 'package:sharepact_app/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as Io;
// import 'package:socket_io_client/socket_io_client.dart';

List<Message> singleChat = [];

class SocketService {
  Io.Socket? socket;
  SocketService(this.ref);
  final Ref ref;

  void connect(
      {required String token, required String userId, required String roomId}) {
    print('object');
    socket = Io.io(
        Config.baseUrl,
        Io.OptionBuilder()
            .setTransports(['websocket']) // For Flutter or Dart VM
            .disableAutoConnect() // Disable automatic connection
            .setExtraHeaders({"token": token})
            .build());
    print('object2');
    // Connect to the server
    socket?.connect();
    print('object3');
    // Handle successful connection
    socket?.onConnect((_) {
      print('connected');

      // Listen for the reply from chat-message event
      socket?.on('chat-message', (data) {
        // print('New message received: $data');
        ref.read(chatProvider1.notifier).getMessages(data);
      });

      // Listen for the reply after fetching messages (messages-{userId})
      socket?.on('messages-$userId', (data) {
        // print('Messages for user $userId: $data');
        // final res = handleMessagesResponse(data);
        ref.read(chatProvider1.notifier).getMessages(data);
      });

      socket?.emit('join-group-chat', roomId);
      print('Sent message to join-group-chat: $roomId');
    });

    // Handle disconnection
    socket?.onDisconnect((_) {
      print('Disconnected from server');
    });
    print({'socket': socket?.connected});
  }

  // Function to send a message to a room
  void sendMessage({required String roomId, required String message}) async {
    socket?.emit('send-message', {'room': roomId, 'msg': message});
    print('Sent message to room: $roomId, message: $message');
  }

  // Function to send a message to a join-group-chat
  void joinRoom({required String roomId}) {
    socket?.emit('join-group-chat', roomId);
    print('Sent message to join-group-chat: $roomId');
  }

  // Function to request previous messages from a room
  void getMessages(
      {required String roomId, required int limit, required String? cursor}) {
    socket?.emit(
        'get-messages', {'room': roomId, 'limit': limit, 'cursor': cursor});
    print('Requesting messages from room: $roomId');
  }

  // Function to handle the reply from chat-message event
  Future<List<Message>> handleMessageResponse1(dynamic data) async {
    print('Handling chat-message response:$data');

    // Check if `data['messages']` is a list or a single message
    if (data['messages'] is List) {
      // If it's a list, parse each message in the list
      print('lidt');
      for (var messageJson in data['messages']) {
        print(messageJson);
        Message message = Message.fromJson(messageJson);
        // Check if the message is already in singleChat by _id before adding
        if (!singleChat
            .any((existingMessage) => existingMessage.id == message.id)) {
          singleChat.add(message);
        }
      }
    } else if (data['messages'] is Map) {
      print('map');
      Message message = Message.fromJson(data['messages']);
      // If it's a single message (Map), parse it directly
      // Check if the message is already in singleChat by _id before adding
      if (!singleChat
          .any((existingMessage) => existingMessage.id == message.id)) {
        singleChat.add(message);
      }
    } else {
      throw Exception('Invalid message format');
    }
    // Sort messages by sentAt in ascending order (older messages at the top)
    singleChat.sort((a, b) => a.sentAt!.compareTo(b.sentAt!));
    // Debugging output
    if (singleChat.isNotEmpty && singleChat.first.content != null) {
      print('Message content: ${singleChat.first.content}');
      print('Sender: ${singleChat.first.sender?.username}');
      print('Sent at: ${singleChat.first.sentAt}');
    }

    return singleChat;
  }

  // Disconnect the socket?
  void disconnect() {
    socket?.disconnect();
  }
}

final chatServiceProvider =
    Provider<SocketService>((ref) => SocketService(ref));
