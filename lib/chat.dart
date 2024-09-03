import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/screens/group_details/screen/group_details_screen.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';

import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  Future<void> connect({String? token}) async {
    await ref.read(profileProvider.notifier).getToken();
    final myToken = ref.read(profileProvider).getToken.value;
    final Socket socket = io(
        'https://improved-endlessly-midge.ngrok-free.app',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({'token': myToken})
            .build());

    socket.connect();
    socket.onConnect((data) => print('connected'));
    socket.onDisconnect((_) => print('disconnected'));
    print(socket.connected);
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() => connect());
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/netflix.png'), // Replace with the path to your image
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Netflix Family', style: TextStyle(color: Colors.black)),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/profile.png'), // Replace with the path to your image
                        radius: 12,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/profile.png'), // Replace with the path to your image
                        radius: 12,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/profile.png'), // Replace with the path to your image
                        radius: 12,
                      ),
                      Text('+ 2 More',
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
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
                        builder: (context) => GroupDetailsScreen()));

                    break;
                  case 'Mute Notifications':
                    // Handle mute notifications action
                    break;
                  case 'Exit Group':
                    // Handle exit group action
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
                    value: 'Mute Notifications',
                    child: Text('Mute Notifications'),
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
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Center(
                        child: Text('Today',
                            style: TextStyle(color: Colors.grey))),
                    const SizedBox(height: 10),
                    _buildReceivedMessage(context, 'John Doe1',
                        'Hi, have you joined the Spotify group yet?', '11:02'),
                    _buildSentMessage(
                        context, 'Hey! Not yet. How do I join?', '11:10'),
                    _buildReceivedMessage(context, 'John Doe1',
                        'Just click on the invite link I sent you.', '11:15'),
                    _buildSentMessage(
                        context, 'Got it, thanks! I’ll join now.', '11:15'),
                  ],
                ),
              ),
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
              child: const TextField(
                decoration: InputDecoration(
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
