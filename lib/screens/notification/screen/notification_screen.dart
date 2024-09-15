import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sharepact_app/api/riverPod/chat2_provider.dart';
import 'package:sharepact_app/api/riverPod/chat_provider.dart';
import 'package:sharepact_app/api/riverPod/get_notifications.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/screens/notification/controller/notification_controller.dart';
import 'package:sharepact_app/screens/notification/model/notification_model.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});
  static const route = '/NotificationScreen';
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  int page = 30;
  @override
  void initState() {
    super.initState();
    Future.microtask(() => getAllNotifications());
    _scrollController = ScrollController()
      ..addListener(() {
        // Trigger when the user scrolls to the bottom
        if (loaging) return;
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loaging = true;
          });
          page = page + 10;
          ref
              .read(notificationsprovider.notifier)
              .getNotifications(limit: page);

          setState(() {
            loaging = false;
          });
        }
      });
  }

  late final ScrollController _scrollController;
  bool loaging = false;
  Future<void> getAllNotifications() async {
    await ref
        .read(notificationsprovider.notifier)
        .getNotifications(limit: page);
  }

  Future<void> markNotifications({required String id}) async {
    await ref.read(profileProvider.notifier).markNotificatoin(id: [id]);
    await ref
        .read(notificationsprovider.notifier)
        .getNotifications(limit: page);
  }

  String timeAgo(String dateTime) {
    // Parse the given string into a DateTime object
    DateTime parsedDateTime = DateTime.parse(dateTime).toUtc();

    // Get the current time in UTC
    DateTime currentTime = DateTime.now().toUtc();

    // Calculate the time difference
    Duration difference = currentTime.difference(parsedDateTime);

    if (difference.inSeconds < 60) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} min ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hrs ago";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days ago";
    } else {
      // For longer durations, you could customize further (e.g., weeks, months)
      return DateFormat.yMMMd().format(parsedDateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationProvider);
    final notification = ref.watch(notificationsprovider);
    final isLoading = ref.watch(notificationsprovider).isLoading;
    ref.watch(chatStateProvider);
    ref.watch(chatProvider1);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notifications",
          style: GoogleFonts.lato(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: notification.when(
                    skipLoadingOnReload: true,
                    skipLoadingOnRefresh: true,
                    data: (data) {
                      final item = data?.data;
                      if (item == null || item.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              AppImages.emptyNotification,
                              width: 80,
                              height: 80,
                            ),
                            Text(
                              "No notifications yet",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "You're all caught up! No new notifications at the moment. Check back later for updates",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        );
                      }
                      return ListView.builder(
                        itemCount: loaging ? item.length + 10 : item.length,
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          final notify = item[index];
                          return SizedBox(
                            height: 120,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (notify.read == false)
                                  Container(
                                    height: 8,
                                    width: 8,
                                    margin: const EdgeInsets.only(top: 5),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                const SizedBox(
                                  width: 20,
                                ),
                                if (notify.subject == 'Login Notification')
                                  SvgPicture.asset(
                                    AppImages.personTick,
                                    width: 24,
                                    height: 24,
                                  ),
                                if (notify.subject ==
                                    'Password Change Notification')
                                  SvgPicture.asset(
                                    AppImages.lock,
                                    width: 24,
                                    height: 24,
                                  ),
                                if (notify.subject == 'New group created')
                                  SvgPicture.asset(
                                    AppImages.peopleIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                if (notify.subject ==
                                    'Email Verified Successfully')
                                  SvgPicture.asset(
                                    AppImages.successIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                if (notify.subject ==
                                    'Your Group has been created')
                                  SvgPicture.asset(
                                    AppImages.peopleIcon,
                                    width: 24,
                                    height: 24,
                                  ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notify.textContent!,
                                        style: GoogleFonts.lato(
                                          color: AppColors.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        timeAgo(notify.createdAt.toString()),
                                        style: GoogleFonts.lato(
                                          color: AppColors.textColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            markNotifications(id: notify.id!);
                                          },
                                          style: OutlinedButton.styleFrom(
                                            fixedSize: const Size(90, 28),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: .0, horizontal: 0.0),
                                            side: const BorderSide(
                                                color: Color(0xFF007BFF)),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Mark Read',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Color(0xFF007BFF),
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    error: (e, s) {
                      return Shimmer.fromColors(
                          baseColor: AppColors.accent,
                          highlightColor: AppColors.primaryColor,
                          child: ListView.builder(
                            itemCount: notifications.userNotifications.length,
                            itemBuilder: (context, index) {
                              NotificationModel notificationModel =
                                  notifications.userNotifications[index];
                              return SizedBox(
                                height: 120,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    notificationModel.isNew
                                        ? Container(
                                            height: 8,
                                            width: 8,
                                            margin:
                                                const EdgeInsets.only(top: 5),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SvgPicture.asset(
                                      notificationModel.icon,
                                      width: 24,
                                      height: 24,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            notificationModel.title,
                                            style: GoogleFonts.lato(
                                              color: AppColors.textColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            notificationModel.time,
                                            style: GoogleFonts.lato(
                                              color: AppColors.textColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomRight,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                notifications
                                                    .removeNotification(index);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                fixedSize: const Size(80, 28),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0,
                                                        horizontal: 10.0),
                                                side: const BorderSide(
                                                    color: Color(0xFF007BFF)),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                              ),
                                              child: const Text(
                                                'Dismiss',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color(0xFF007BFF),
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ));
                    },
                    loading: () => Shimmer.fromColors(
                        baseColor: AppColors.accent,
                        highlightColor: AppColors.primaryColor,
                        child: ListView.builder(
                          itemCount: notifications.userNotifications.length,
                          itemBuilder: (context, index) {
                            NotificationModel notificationModel =
                                notifications.userNotifications[index];
                            return SizedBox(
                              height: 120,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  notificationModel.isNew
                                      ? Container(
                                          height: 8,
                                          width: 8,
                                          margin: const EdgeInsets.only(top: 5),
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle,
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SvgPicture.asset(
                                    notificationModel.icon,
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notificationModel.title,
                                          style: GoogleFonts.lato(
                                            color: AppColors.textColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          notificationModel.time,
                                          style: GoogleFonts.lato(
                                            color: AppColors.textColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: OutlinedButton(
                                            onPressed: () {
                                              notifications
                                                  .removeNotification(index);
                                            },
                                            style: OutlinedButton.styleFrom(
                                              fixedSize: const Size(80, 28),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 10.0),
                                              side: const BorderSide(
                                                  color: Color(0xFF007BFF)),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                            ),
                                            child: const Text(
                                              'Dismiss',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                color: Color(0xFF007BFF),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ))),
              ),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Container()
            ],
          )),
    );
  }
}
