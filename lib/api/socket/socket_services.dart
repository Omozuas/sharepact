import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/chat_model.dart';
import 'package:sharepact_app/api/riverPod/chat2_provider.dart';
import 'package:sharepact_app/config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:socket_io_client/socket_io_client.dart';

// List<Message> singleChat = [];
// List<Message> singleChat = [];
// Map<String, List<Message>> chatRooms = {};

class SocketService {
  io.Socket? socket;
  SocketService(this.ref);
  final Ref ref;

  void connect(
      {required String token, required String userId, required String roomId}) {
    log('staert io');
    socket = io.io(
        Config.baseUrl1,
        io.OptionBuilder()
            .setTransports(['websocket']) // For Flutter or Dart VM
            .disableAutoConnect() // Disable automatic connection
            .setExtraHeaders({"token": token})
            .enableForceNew() // Ensure a fresh connection is established
            .enableReconnection() // Auto-reconnect if connection is lost
            .build());
    // Connect to the server
    socket?.connect();
    // Handle successful connection
    socket?.onConnect((_) {
      // Listen for the reply from chat-message event
      log('onconnnected');
      socket?.on('chat-message', (data) {
        ref
            .read(chatProvider1.notifier)
            .getMessages(data: data, roomId: roomId);
      });

      // Listen for the reply after fetching messages (messages-{userId})
      socket?.on('messages-$userId', (data) {
        // final res = handleMessagesResponse(data);

        ref
            .read(chatProvider1.notifier)
            .getMessages(data: data, roomId: roomId);
      });

      socket?.emit('join-group-chat', roomId);
    });

    // Handle disconnection
    socket?.onDisconnect((_) {});
  }

  // Function to send a message to a room
  void sendMessage({required String roomId, required String message}) async {
    socket?.emit('send-message', {'room': roomId, 'msg': message});
  }

  // Function to send a message to a join-group-chat
  void joinRoom({required String roomId}) {
    socket?.emit('join-group-chat', roomId);
  }

  // Function to request previous messages from a room
  void getMessages(
      {required String roomId, required int limit, required String? cursor}) {
    socket?.emit(
        'get-messages', {'room': roomId, 'limit': limit, 'cursor': cursor});
  }

  // Function to handle the reply from chat-message event
  Future<List<Message>> handleMessageResponse1(
      {required dynamic data, required String roomId}) async {
    List<Message> singleChat = [];

    // Check if `data['messages']` is a list or a single message
    if (data['messages'] is List) {
      // If it's a list, parse each message in the list
      for (var messageJson in data['messages']) {
        Message message = Message.fromJson(messageJson);
        // Check if the message is already in singleChat by _id before adding
        if (!singleChat
            .any((existingMessage) => existingMessage.id == message.id)) {
          singleChat.add(message);
        }
      }
    } else if (data['messages'] is Map) {
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

    return singleChat;
  }

  // Disconnect the socket?
  void disconnect() {
    socket?.disconnect();
  }
}

final chatServiceProvider =
    Provider<SocketService>((ref) => SocketService(ref));
