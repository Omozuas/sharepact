// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/userProvider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/bottom_nav_bar.dart';
import 'package:sharepact_app/groups.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/screens/home/home.dart';
import 'package:sharepact_app/settings.dart';
import 'package:sharepact_app/subscriptions.dart';

class ControllerNavScreen extends ConsumerStatefulWidget {
  const ControllerNavScreen({super.key, this.initialIndex = 0});
  final int? initialIndex;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ControllerNavScreenState();
}

class _ControllerNavScreenState extends ConsumerState<ControllerNavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex!;
    Future.microtask(() => getAll());
  }

  Future<void> getAll() async {
    try {
      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      await ref
          .read(profileProvider.notifier)
          .checkTokenStatus(token: myToken!);
      final isTokenValid = ref.watch(profileProvider).checkTokenstatus.value;
      print(isTokenValid?.data);
      if (isTokenValid?.code != 200) {
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
      print('Unexpected Error: $e');
      print('StackTrace: $stackTrace');
      showErrorPopup(
          context: context, message: 'An unexpected error occurred.');
    }
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SubscriptionsScreen(),
    GroupsScreen(),
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
        print("object");
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
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add),
              )
            : null, // Hide FAB for other screens
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
