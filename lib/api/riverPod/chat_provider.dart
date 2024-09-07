import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/chat_model.dart';
import 'package:sharepact_app/api/socket/socket_services.dart';

class ChatProvider extends AutoDisposeNotifier<ChatProviderStates> {
  @override
  ChatProviderStates build() {
    return const ChatProviderStates(
        chatrespond: AsyncData(null), singleChat: AsyncData(null));
  }

  void connect(
      {required String token, required String userId, required String roomId}) {
    final chat = ref.read(chatServiceProvider);
    chat.connect(token: token, userId: userId, roomId: roomId);
  }

  void disConnect() {
    final chat = ref.read(chatServiceProvider);
    chat.disconnect();
  }

  void sendMessage({required String roomId, required String message}) {
    final chat = ref.read(chatServiceProvider);
    chat.sendMessage(roomId: roomId, message: message);
  }

  void getMessagess(
      {required String roomId, required int limit, required String? cursor}) {
    final chat = ref.read(chatServiceProvider);
    state = state.copyWith(chatrespond: const AsyncLoading());
    chat.getMessages(roomId: roomId, limit: limit, cursor: cursor);
  }
}

final chatStateProvider =
    AutoDisposeNotifierProvider<ChatProvider, ChatProviderStates>(
        ChatProvider.new);

class ChatProviderStates {
  final AsyncValue<MessageResponse?> chatrespond;
  final AsyncValue<List<Message>?> singleChat;

  const ChatProviderStates({
    required this.chatrespond,
    required this.singleChat,
  });

  ChatProviderStates copyWith({
    AsyncValue<MessageResponse?>? chatrespond,
    AsyncValue<List<Message>?>? singleChat,
  }) {
    return ChatProviderStates(
      chatrespond: chatrespond ?? this.chatrespond,
      singleChat: singleChat ?? this.singleChat,
    );
  }
}
