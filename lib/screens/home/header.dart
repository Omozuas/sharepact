import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/screens/notification/screen/notification_screen.dart';

class Header extends ConsumerStatefulWidget {
  const Header({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<Header> {
  @override
  Widget build(
    BuildContext context,
  ) {
    final isLoading = ref.watch(profileProvider).getUser.isLoading;
    final user = ref.watch(profileProvider).getUser.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isLoading
            ? const Text(
                'Hi',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              )
            : Text(
                'Hi ${user?.username}',
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
            isLoading
                ? const CircleAvatar(
                    backgroundImage: AssetImage("assets/avatars/image2.png"),
                    radius: 24,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage("${user?.avatarUrl}"),
                    radius: 24,
                  )
          ],
        )
      ],
    );
  }
}
