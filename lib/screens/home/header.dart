import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/get_notifications.dart';
import 'package:sharepact_app/api/riverPod/user_provider.dart';
import 'package:sharepact_app/screens/settings_screen/edit_profile.dart';
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
    final user = ref.watch(userProvider);
    final notification = ref.watch(notificationsprovider);
    return user.when(
        skipLoadingOnReload: true,
        data: (user) {
          if (user?.avatarUrl == null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                'Hi ${user?.username}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  Stack(children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ));
                      },
                      child: Image.asset(
                        'assets/notification.png', // Replace with actual image path
                        width: 25,
                        height: 25,
                      ),
                    ),
                    if ('${notification.value?.data?.where((test) => test.read == false).length}' !=
                        '0')
                      Positioned(
                        top: -5,
                        right: 1,
                        child: Container(
                          height: 13,
                          width: 13,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${notification.value?.data?.where((test) => test.read == false).length}',
                              style: const TextStyle(
                                  fontSize: 6, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                  ]),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfile(),
                      ));
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("${user?.avatarUrl}"),
                      radius: 24,
                    ),
                  )
                ],
              )
            ],
          );
        },
        error: (e, st) {
          return Row(
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
              ]);
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
