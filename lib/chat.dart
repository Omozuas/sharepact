import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/chat2_provider.dart';
import 'package:sharepact_app/api/riverPod/chat_provider.dart';
import 'package:sharepact_app/api/riverPod/groupDetailsProvider.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/api/socket/socket_services.dart';
import 'package:sharepact_app/screens/group_details/screen/group_details_screen.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  String userId = '';
  Future<void> getToken() async {
    await ref.read(profileProvider.notifier).getToken();
    await ref.read(profileProvider.notifier).getuserId();
    final myToken = ref.read(profileProvider).getToken.value;
    final myid = ref.read(profileProvider).getUserId.value;
    setState(() {
      userId = myid!;
    });
    print({myToken, myid});
    ref.read(chatStateProvider.notifier).connect(
        token: myToken!, userId: myid!, roomId: '66d6da40712d196a6a915636');
    _getAllMessage();
    getGroupDetails();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Scroll to bottom every time new data is rendered
      _scrollToBottom();
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getToken());
    _scrollController.addListener(_onScroll);
  }

  // Function to scroll to the bottom of the list
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Disconnect the socket when the widget is disposed
    // disConnect();
    singleChat.clear();
    _scrollController.dispose();
    print('ddd');
  }

  void disConnect() {
    ref.read(chatServiceProvider).disconnect();
  }

  // Function to detect scroll position and load more messages when at the top
  void _onScroll() {
    if (_scrollController.position.pixels == 0 && !_isLoadingMore) {
      _loadMoreMessages();
    }
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Scroll to bottom every time new data is rendered
        _scrollToBottom();
      });
      ref.read(chatStateProvider.notifier).sendMessage(
          roomId: '66d6da40712d196a6a915636', message: _messageController.text);

      _messageController.clear();
    }
  }

  int page = 20;
  // Function to load more messages
  void _loadMoreMessages() async {
    if (_isLoadingMore) return;
    setState(() {
      _isLoadingMore = true;
    });

    page = page + 20;

    // Replace this with your logic to load more data (e.g., pagination)
    ref.read(chatStateProvider.notifier).getMessagess(
        roomId: '66d6da40712d196a6a915636', limit: page, cursor: null);
    // Restore the scroll position after loading more data

    setState(() {
      _isLoadingMore = false;
    });
  }

  void _getAllMessage() {
    ref.read(chatStateProvider.notifier).getMessagess(
        roomId: '66d6da40712d196a6a915636', limit: 20, cursor: null);
    // singleChat.clear();
  }

  Future<void> getGroupDetails() async {
    await ref
        .read(groupdetailsprovider.notifier)
        .getGroupDetailsById(id: '66d6da40712d196a6a915636');
    // final res = ref.watch(groupdetailsprovider).value;
    // print(res?.data?.joinRequests?[0]);
  }

  Future<void> _leaveGroup({required String roomId}) async {
    try {
      await ref.read(profileProvider.notifier).leaveGroup(roomId: roomId);

      final pUpdater = ref.read(profileProvider).leaveGroup;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ControllerNavScreen(
                        initialIndex: 2,
                      )),
            );
            showSuccess(message: message!, context: context);
          } else {
            showErrorPopup(message: message, context: context);
          }
        }
      }
    } catch (e) {
      // Show error if login fails
      if (mounted) {
        showErrorPopup(
            message: e.toString().replaceAll('Exception: ', ''),
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final res = ref.watch(chatProvider1);
    ref.watch(chatStateProvider);
    final res2 = ref.watch(groupdetailsprovider);
    final isLoading = ref.watch(groupdetailsprovider).isLoading;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ControllerNavScreen(
                      initialIndex: 2,
                    )));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ControllerNavScreen(
                          initialIndex: 2,
                        )),
              );
            },
          ),
          title: Row(
            children: [
              isLoading
                  ? Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/netflix.png'), // Replace with the path to your image
                      ))
                  : res2.value?.data != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(res2.value!.data!
                              .serviceLogo!), // Replace with the path to your image
                        )
                      : Shimmer.fromColors(
                          baseColor: AppColors.accent,
                          highlightColor: AppColors.primaryColor,
                          child: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/netflix.png'), // Replace with the path to your image
                          )),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      isLoading
                          ? ''
                          : res2.value?.data != null
                              ? res2.value!.data!.groupName!
                              : '',
                      style: const TextStyle(color: Colors.black)),
                  Row(
                    children: [
                      SizedBox(
                          height: 20,
                          width: 70,
                          child: res2.when(
                              data: (data) {
                                final item = data?.data?.members;
                                if (item != null && item.isNotEmpty) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          item.length > 3 ? 3 : item.length,
                                      itemBuilder: (context, index) {
                                        final item1 = item[index];
                                        return CircleAvatar(
                                          backgroundImage: NetworkImage(item1
                                              .user!
                                              .avatarUrl!), // Replace with the path to your image
                                          radius: 12,
                                        );
                                      });
                                }
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Shimmer.fromColors(
                                          baseColor: AppColors.accent,
                                          highlightColor:
                                              AppColors.primaryColor,
                                          child: const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/profile.png'), // Replace with the path to your image
                                            radius: 12,
                                          ));
                                    });
                              },
                              error: (e, s) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Shimmer.fromColors(
                                          baseColor: AppColors.accent,
                                          highlightColor:
                                              AppColors.primaryColor,
                                          child: const CircleAvatar(
                                            backgroundImage: AssetImage(
                                                'assets/profile.png'), // Replace with the path to your image
                                            radius: 12,
                                          ));
                                    });
                              },
                              loading: () => ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Shimmer.fromColors(
                                        baseColor: AppColors.accent,
                                        highlightColor: AppColors.primaryColor,
                                        child: const CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/profile.png'), // Replace with the path to your image
                                          radius: 12,
                                        ));
                                  }))),
                      Text(
                          '+ ${((res2.value?.data?.members?.length ?? 0) - 3).clamp(0, double.infinity).toInt()} More',
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (String value) {
                // Handle menu item selection here
                switch (value) {
                  case 'Group details':
                    // Handle group details action
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const GroupDetailsScreen()));

                    break;
                  case 'Exit Group':
                    // Handle exit group action
                    _leaveGroup(roomId: '');
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'Group details',
                    child: Text('Group details'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Exit Group',
                    child: Text(
                      'Exit Group',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: res.when(
                      skipLoadingOnReload: true,
                      data: (data) {
                        print('Message count in UI: ${data?.length}');
                        if (data != null && data.isNotEmpty) {
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   // Scroll to bottom every time new data is rendered
                          //   _scrollToBottom();
                          // });
                          return ListView.builder(
                              itemCount: _isLoadingMore
                                  ? data.length + 20
                                  : data.length,
                              shrinkWrap: true,
                              controller: _scrollController,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, index) {
                                var item1 = data[index];
                                // Show loading indicator when loading more messages
                                if (_isLoadingMore) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
                                if (item1.sender?.id != userId) {
                                  return _buildReceivedMessage1(
                                      context: context,
                                      sender: item1.sender!.username!,
                                      message: item1.content!,
                                      time: DateTime.parse(
                                              item1.sentAt!.toString())
                                          .toString(),
                                      img: item1.sender!.avatarUrl!);
                                } else {
                                  return _buildSentMessage1(
                                      context: context,
                                      message: item1.content!,
                                      time: DateTime.parse(
                                              item1.sentAt!.toString())
                                          .toString(),
                                      img: item1.sender!.avatarUrl!);
                                }
                              });
                        }
                        return Container();
                      },
                      error: (e, s) {
                        return Text('Error: $e');
                      },
                      loading: () => Shimmer.fromColors(
                          baseColor: AppColors.accent,
                          highlightColor: AppColors.primaryColor,
                          child: ListView.builder(
                              itemCount: 1,
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, index) {
                                return Column(children: [
                                  _buildReceivedMessage(context, '', '', ''),
                                  _buildSentMessage(
                                    context,
                                    '',
                                    '',
                                  ),
                                ]);
                              })))),

              _buildMessageInput(),
              // const SizedBox(height: 50), // Add some space below the input box
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(
      BuildContext context, String sender, String message, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(
              'assets/profile.png'), // Replace with the path to your avatar image
          radius: 12,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 264,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xffFFF2E8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$sender\n',
                      style: const TextStyle(
                        color: Color(0xffFD7E14),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: message,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(time,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildSentMessage(BuildContext context, String message, String time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 191,
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xffE6F2FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(time,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(width: 8),
        const CircleAvatar(
          backgroundImage: AssetImage(
              'assets/profile.png'), // Replace with the path to your avatar image
          radius: 12,
        ),
      ],
    );
  }

  Widget _buildReceivedMessage1(
      {required BuildContext context,
      required String sender,
      required String message,
      required String time,
      required String img}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage:
              NetworkImage(img), // Replace with the path to your avatar image
          radius: 12,
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 264,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xffFFF2E8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$sender\n',
                      style: const TextStyle(
                        color: Color(0xffFD7E14),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                    TextSpan(
                      text: message,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(time,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildSentMessage1(
      {required BuildContext context,
      required String message,
      required String time,
      required String img}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 191,
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xffE6F2FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(time,
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          backgroundImage:
              NetworkImage(img), // Replace with the path to your avatar image
          radius: 12,
        ),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    24), // Make the input box fully rounded
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type here',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: Image.asset(
                  'assets/send_icon.png'), // Replace with the path to your send icon image
              onPressed: () {
                // Handle send message

                _sendMessage();
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ChatScreen(),
  ));
}
