import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sharepact_app/api/riverPod/categoryProvider.dart';
import 'package:sharepact_app/api/riverPod/chat_provider.dart';
import 'package:sharepact_app/api/riverPod/get_notifications.dart';
import 'package:sharepact_app/api/riverPod/group_list.dart';
import 'package:sharepact_app/api/riverPod/subscription_provider.dart';
import 'package:sharepact_app/api/riverPod/user_provider.dart';
import 'package:sharepact_app/screens/group_details/screen/chat.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class GroupsScreen extends ConsumerStatefulWidget {
  const GroupsScreen({super.key});

  @override
  ConsumerState createState() => GroupsScreenState();
}

class GroupsScreenState extends ConsumerState<GroupsScreen> {
  final List<Map<String, String>> groupsData = [
    {
      'icon': 'assets/netflix.png',
      'title': 'Netflix Family',
      'subtitle': 'JaneDoe1: How\'s it going guys?..',
      'badge': '10'
    },
    {
      'icon': 'assets/spotify.png',
      'title': 'Spotify Family',
      'subtitle': 'JaneDoe1: How\'s it going guys?..',
      'badge': '10'
    },
  ];

  int limit = 15;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => getGrouplist());
    _scrollController = ScrollController()
      ..addListener(() {
        // Trigger when the user scrolls to the bottom
        if (loaging) return;
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loaging = true;
          });
          limit = limit + 10;
          ref.read(groupListprovider.notifier).getGroupList(limit: limit);
          setState(() {
            loaging = false;
          });
        }
      });
  }

  Future<void> getGrouplist() async {
    await ref.read(groupListprovider.notifier).getGroupList();
  }

  late final ScrollController _scrollController;
  bool loaging = false;
  @override
  Widget build(BuildContext context) {
    final res = ref.watch(groupListprovider);
    ref.watch(userProvider);
    ref.watch(categoryProvider);
    ref.watch(subscriptionProvider);
    ref.watch(chatStateProvider);
    ref.watch(notificationsprovider);
    final isLoading = ref.read(groupListprovider).isLoading;
    return RefreshIndicator(
      onRefresh: () async {
        getGrouplist();
      },
      child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('My Groups',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff5D6166),
                          )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              res.when(
                  skipLoadingOnReload: true,
                  data: (data) {
                    if (data?.data?.groups != null &&
                        data!.data!.groups!.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: loaging
                              ? data!.data!.groups!.length + 10
                              : data?.data?.groups?.length,
                          itemBuilder: (context, index) {
                            final item = data?.data?.groups?[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            roomId: item.id,
                                          )),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 77,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(item!.service!.logoUrl!),
                                      radius: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(item.groupName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: const Color.fromRGBO(
                                                        52, 58, 64, 1),
                                                  )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          if (item.latestMessage?.sender!
                                                  .username !=
                                              null)
                                            Text(
                                              '${item.latestMessage?.sender?.username!} : ${item.latestMessage?.content!}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color.fromRGBO(
                                                        93, 97, 102, 1),
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (item.unreadMessages != 0)
                                      CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        radius: 13,
                                        child: Text(
                                          item.unreadMessages.toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 10),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      heightFactor: 1.5,
                      child: SizedBox(
                        width: 290,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/empty.json"),
                            Text(
                              "You haven't joined any groups yet",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Your subscribed groups will appear here once you create or join a subscription group",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  error: (error, s) {
                    return Shimmer.fromColors(
                        baseColor: AppColors.accent,
                        highlightColor: AppColors.primaryColor,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: groupsData.length,
                          itemBuilder: (context, index) {
                            final group = groupsData[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ChatScreen()),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 77,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage(group['icon']!),
                                      radius: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            group['title']!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            group['subtitle']!,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 13,
                                      child: Text(
                                        group['badge']!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ));
                  },
                  loading: () => Shimmer.fromColors(
                        baseColor: AppColors.accent,
                        highlightColor: AppColors.primaryColor,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: groupsData.length,
                          itemBuilder: (context, index) {
                            final group = groupsData[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ChatScreen()),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 77,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF8F9FA),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          AssetImage(group['icon']!),
                                      radius: 24,
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            group['title']!,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            group['subtitle']!,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.grey,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                    CircleAvatar(
                                      backgroundColor: Colors.blue,
                                      radius: 13,
                                      child: Text(
                                        group['badge']!,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
            ],
          )),
    );
  }
}
