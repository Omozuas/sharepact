import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/chat_model.dart';
import 'package:sharepact_app/api/socket/socket_services.dart';

// Central store for messages per chat (roomId)

class ChatProvider1
    extends AutoDisposeAsyncNotifier<Map<String, List<Message>>?> {
  @override
  Future<Map<String, List<Message>>?> build() async {
    return {};
  }

  Future<void> getMessages(
      {required dynamic data, required String roomId}) async {
    final chat = ref.read(chatServiceProvider);
    log('starting from API $roomId');

    try {
      state = const AsyncLoading();
      final response =
          await chat.handleMessageResponse1(data: data, roomId: roomId);
      // Log API response to check if it's returning empty
      // log('Response from API: ${response.length}');
// Add or append messages for the current room
      Map<String, List<Message>> chatRooms = state.value ?? {};
      // log(' chats$chatRooms');
      if (response.isNotEmpty) {
        List<Message> messages = chatRooms.putIfAbsent(roomId, () => []);
        // Filter and add new messages to avoid duplicates
        var newMessages = response
            .where((m) => !messages.any((em) => em.id == m.id))
            .toList();
        messages.addAll(newMessages);
        messages.sort((a, b) => a.sentAt!.compareTo(b.sentAt!));
        state = AsyncData(chatRooms);
        // log('Updated messages for room $roomId');
        // if (chatRooms.containsKey(roomId)) {
        //   log('the chat${chatRooms[roomId]}');

        //   // Fetch existing messages for the room
        //   List<Message> existingMessages = chatRooms[roomId]!;

        //   // Avoid duplicates by checking message ID
        //   for (var message in response) {
        //     if (!existingMessages
        //         .any((existingMessage) => existingMessage.id == message.id)) {
        //       existingMessages.add(message);
        //     }
        //   }

        //   // Sort messages by sentAt to maintain the correct order
        //   existingMessages.sort((a, b) => a.sentAt!.compareTo(b.sentAt!));
        //   chatRooms[roomId] = existingMessages;
        //   state = AsyncData(chatRooms);
        // } else {
        //   // If room does not exist, add it with the fetched messages
        //   chatRooms[roomId] = response;
        //   state = AsyncData(chatRooms);
        // }
        log('chat:$chatRooms');
      } else {
        log('No new messages for room $roomId.');
      }

      // Notify UI about the update
      // state = AsyncData(chatRooms);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final chatProvider1 = AutoDisposeAsyncNotifierProvider<ChatProvider1,
    Map<String, List<Message>>?>(ChatProvider1.new);
