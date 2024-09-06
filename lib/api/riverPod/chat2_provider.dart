import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/chat_model.dart';
import 'package:sharepact_app/api/socket/socket_services.dart';

class ChatProvider1 extends AutoDisposeAsyncNotifier<List<Message>?> {
  @override
  Future<List<Message>?> build() async {
    return null;
  }

  Future<void> getMessages(dynamic data) async {
    final chat = ref.read(chatServiceProvider);
    print('object');
    try {
      state = const AsyncLoading();
      final response = await chat.handleMessageResponse1(data);
      print({'rswew': response.toList()});
      // Assuming 'response' is a list of maps or objects with 'messageId'

      state = AsyncData(response);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}

final chatProvider1 =
    AutoDisposeAsyncNotifierProvider<ChatProvider1, List<Message>?>(
        ChatProvider1.new);
