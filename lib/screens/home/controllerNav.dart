import 'package:flutter/material.dart';
import 'package:sharepact_app/bottom_nav_bar.dart';
import 'package:sharepact_app/groups.dart';
import 'package:sharepact_app/screens/home/home.dart';
import 'package:sharepact_app/settings.dart';
import 'package:sharepact_app/subscriptions.dart';

class ControllerNavScreen extends StatefulWidget {
  const ControllerNavScreen({super.key});

  @override
  State<ControllerNavScreen> createState() => _ControllerNavScreenState();
}

class _ControllerNavScreenState extends State<ControllerNavScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('object');
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

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        print("object");
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: _screens[_selectedIndex],
          ),
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
