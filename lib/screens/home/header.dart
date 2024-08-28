import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';

import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/screens/notification/screen/notification_screen.dart';

class Header extends ConsumerStatefulWidget {
  const Header({super.key, this.userModel});
  final UserModel? userModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<Header> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final user = ref.watch(profileProvider).getUser;

    return user.when(
        data: (user) {
          if (widget.userModel?.avatarUrl == null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hi ${widget.userModel?.username}',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ));
                      },
                      child: Image.asset(
                        'assets/notification.png', // Replace with actual image path
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/avatars/image2.png"),
                      radius: 24,
                    )
                  ],
                )
              ],
            );
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hi ${widget.userModel?.username}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const NotificationScreen(),
                      ));
                    },
                    child: Image.asset(
                      'assets/notification.png', // Replace with actual image path
                      width: 24,
                      height: 24,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage("${widget.userModel?.avatarUrl}"),
                    radius: 24,
                  )
                ],
              )
            ],
          );
        },
        error: (e, st) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Error loading user: $e'),
                ElevatedButton(
                  onPressed: () {
                    // Add retry logic here
                    ref.read(profileProvider.notifier).getUserDetails();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        loading: () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hi',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ));
                      },
                      child: Image.asset(
                        'assets/notification.png', // Replace with actual image path
                        width: 24,
                        height: 24,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/avatars/image2.png"),
                      radius: 24,
                    )
                  ],
                )
              ],
            ));
  }
}
