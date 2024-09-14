// ignore_for_file: file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/user_provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/bottom_nav_bar.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/screens/group_details/screen/groups_screen.dart';
import 'package:sharepact_app/screens/home/home.dart';
import 'package:sharepact_app/screens/services_screen/create_group2.dart';
import 'package:sharepact_app/screens/settings_screen/settings.dart';
import 'package:sharepact_app/screens/subscriptionScreen/subscriptions.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:sharepact_app/widgets/popup_content.dart';
import 'package:sharepact_app/widgets/popup_input_widget.dart';

class ControllerNavScreen extends ConsumerStatefulWidget {
  const ControllerNavScreen({super.key, this.initialIndex = 0});
  final int? initialIndex;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ControllerNavScreenState();
}

class _ControllerNavScreenState extends ConsumerState<ControllerNavScreen> {
  final TextEditingController messageController = TextEditingController();

  final TextEditingController codeController = TextEditingController();
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    log('hi 2');
    _selectedIndex = widget.initialIndex!;
    Future.microtask(() => getAll());
  }

  Future<void> getAll() async {
    try {
      await ref.read(profileProvider.notifier).validateToken();
      final isTokenValid = ref.read(profileProvider).isTokenValid.value;
      if (isTokenValid == false) {
        _handleSessionExpired();
        return;
      }
      await _fetchUserData();
    } catch (e, stackTrace) {
      _handleUnexpectedError(e, stackTrace);
    }
  }

  void _handleSessionExpired() {
    if (mounted) {
      showErrorPopup(context: context, message: 'Session Expired');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return;
    }
  }

  Future<void> _fetchUserData() async {
    await ref.read(userProvider.notifier).getUserDetails();
    final user = ref.watch(userProvider);
    if (user.error != null) {
      _handleError(user.error.toString());
      return;
    }
  }

  void _handleError([String? message]) {
    showErrorPopup(context: context, message: message);
    return;
  }

  void _handleUnexpectedError(Object e, StackTrace stackTrace) {
    if (mounted) {
      showErrorPopup(
          context: context, message: 'An unexpected error occurred.');
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SubscriptionsScreen(),
    const GroupsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Define the screens for each index
    ref.watch(profileProvider).checkTokenstatus;
    ref.watch(userProvider);
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: _screens[_selectedIndex],
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
        // Conditionally show the FAB only for the SettingsScreen (index 3)
        floatingActionButton: _selectedIndex != 3
            ? FloatingActionButton(
                onPressed: () {
                  // Add your onPressed code here!
                  _showJoinGroupOrCreate(context);
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              )
            : null, // Hide FAB for other screens
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _showJoinGroupDialog(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(profileProvider).getGroupbyCode.isLoading;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: PopupInputWidget(
            textController: codeController,
            title: "Group Code",
            subtext:
                "Please enter the group code provided by the group creator to join the subscription group",
            hintText: 'Enter code',
            btnText: isLoading ? 'proceeding...' : 'Proceed',
            onPressed: isLoading
                ? () {}
                : () {
                    _isGroupExisting(roomId: codeController.text);
                    Navigator.pop(context);
                  },
          ),
        );
      },
    );
  }

  void _showJoinGroupDialogPass(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(profileProvider).joinGroup.isLoading;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: PopupInputWidget(
                  title: "Message",
                  subtext:
                      "Please send a message to the group creator about your intention to join the group",
                  minLines: 5,
                  btnText: isLoading ? 'sending...' : 'Send Message',
                  textController: messageController,
                  height: 320,
                  hintText:
                      'Hi creator, I’d like to become a member of this group ',
                  onPressed: () {
                    _joinGroup(
                        roomId: codeController.text,
                        message: messageController.text);
                    Navigator.pop(context);
                  }));
        });
  }

  void _showJoinGroupDialogFailed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            // contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: PopupContentWidget(
              icon: AppImages.invalidIcon,
              title: "Invalid Group Code!",
              subtext:
                  "The group code you entered is incorrect. Please try again or reach out to the group creator if you believe the code provided is incorrect",
              actionBtnText: "Try Again",
              buttonColor: AppColors.primaryColor,
              onPressed: () {
                Navigator.pop(context);
                _showJoinGroupDialog(context, ref);
              },
            ),
          );
        });
  }

  void _showJoinGroupDialogPassMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: PopupContentWidget(
                icon: AppImages.successIcon,
                title: "Request Sent!",
                subtext:
                    "Your request to join the group has been sent successfully",
                actionBtnText: "Join More Groups",
                buttonColor: AppColors.primaryColor,
                closeBtnText: 'Close',
                onPressed: () {
                  Navigator.pop(context);
                  _showJoinGroupDialog(context, ref);
                },
              ));
        });
  }

  Future<void> _isGroupExisting({required String roomId}) async {
    try {
      await ref.read(profileProvider.notifier).getGroupByCode(groupId: roomId);

      final pUpdater = ref.read(profileProvider).getGroupbyCode;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          // final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful

            _showJoinGroupDialogPass(context, ref);
          } else {
            _showJoinGroupDialogFailed(context);
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

  Future<void> _joinGroup(
      {required String roomId, required String message}) async {
    try {
      await ref
          .read(profileProvider.notifier)
          .joinAGroup(groupCode: roomId, message: message);

      final pUpdater = ref.read(profileProvider).joinGroup;
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
            _showJoinGroupDialogPassMessage(context);
            codeController.clear();
            messageController.clear();
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

  void _showJoinGroupOrCreate(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              // contentPadding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              content: PopupContentWidget(
                title: 'Join Group Or Create A group',
                subtext: "you can Create And Join a Group",
                actionBtnText: "Join Groups",
                buttonColor: AppColors.primaryColor,
                closeBtnText: 'Create Group',
                onPressed2: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateGroup2()),
                  );
                },
                onPressed: () {
                  Navigator.pop(context);
                  _showJoinGroupDialog(context, ref);
                },
              ));
        });
  }
}
