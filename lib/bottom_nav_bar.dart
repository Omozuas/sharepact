import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sharepact_app/api/riverPod/user_provider.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    log('hi 1');
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userProvider);
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/home.svg',
            color: widget.selectedIndex == 0 ? Colors.blue : null,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/card.svg',
            color: widget.selectedIndex == 1 ? Colors.blue : null,
          ),
          label: 'Subscriptions',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/people.svg',
            colorFilter: ColorFilter.mode(
                widget.selectedIndex == 2 ? Colors.blue : Colors.grey,
                BlendMode.srcIn),
          ),
          label: 'Groups',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/setting-2.svg',
            colorFilter: ColorFilter.mode(
                widget.selectedIndex == 3 ? Colors.blue : Colors.grey,
                BlendMode.srcIn),
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
