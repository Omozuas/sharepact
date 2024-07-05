import 'package:flutter/material.dart';
import 'package:sharepact_app/groups.dart';
import 'package:sharepact_app/screens/home/components/service_widget.dart';
import 'package:sharepact_app/screens/home/components/subscription_card.dart';
import 'package:sharepact_app/screens/home/header.dart';
import 'package:sharepact_app/bottom_nav_bar.dart';
import 'package:sharepact_app/settings.dart';
import 'package:sharepact_app/streaming_services.dart'; // Import the StreamingServicesScreen
import 'package:sharepact_app/subscriptions.dart'; // Import MySubscriptionsScreen



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  void _navigateToStreamingServices(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StreamingServicesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define the screens for each index
    List<Widget> _screens = [
      _homeScreenContent(context),
      SubscriptionsScreen(),
      GroupsScreen(),
      SettingsScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _homeScreenContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 53,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/search.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search subscriptions',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Available Services',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ServiceWidget(
                    imgaeURL: 'assets/streaming.png',
                    title: 'Streaming Services',
                    onTap: () => _navigateToStreamingServices(context),
                  ),
                  ServiceWidget(
                    imgaeURL: 'assets/streaming.png',
                    title: 'Streaming Services',
                    onTap: () => _navigateToStreamingServices(context),
                  ),
                  ServiceWidget(
                    imgaeURL: 'assets/streaming.png',
                    title: 'Streaming Services',
                    onTap: () => _navigateToStreamingServices(context),
                  ),
                  ServiceWidget(
                    imgaeURL: 'assets/streaming.png',
                    title: 'Streaming Services',
                    onTap: () => _navigateToStreamingServices(context),
                  ),
                  ServiceWidget(
                    imgaeURL: 'assets/streaming.png',
                    title: 'Streaming Services',
                    onTap: () => _navigateToStreamingServices(context),
                  ),
                  ServiceWidget(
                    imgaeURL: 'assets/streaming.png',
                    title: 'Streaming Services',
                    onTap: () => _navigateToStreamingServices(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Subscriptions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Show All",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            ),
            const SizedBox(height: 16),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2.5,
              ),
              child: SubscriptionGrid(),
              
            ),
             const SizedBox(height: 30),
                      ],        
        ),
        
      ),
    );
  }
}

class SubscriptionGrid extends StatelessWidget {
  final List<Map<String, String>> subscriptionData = [
    {
      'service': 'Canva',
      'price': '10,000 NGN',
      'members': '5/5 members',
      'nextpayment': '12/01/2025',
      'createdby': 'JohnDoe1'
    },
    {
      'service': 'Netflix',
      'price': '5,000 NGN',
      'members': '3/4 members',
      'nextpayment': '15/01/2025',
      'createdby': 'JaneDoe2'
    },
    {
      'service': 'Netflix',
      'price': '5,000 NGN',
      'members': '3/4 members',
      'nextpayment': '15/01/2025',
      'createdby': 'JaneDoe2'
    },
    {
      'service': 'Netflix',
      'price': '5,000 NGN',
      'members': '3/4 members',
      'nextpayment': '15/01/2025',
      'createdby': 'JaneDoe2'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 5,
        childAspectRatio: 220 / 207,
      ),
      itemCount: subscriptionData.length,
      itemBuilder: (context, index) {
        final data = subscriptionData[index];
        return Opacity(
          opacity: 1.0,
          child: SubscriptionCard(
            service: data['service']!,
            price: data['price']!,
            members: data['members']!,
            nextpayment: data['nextpayment']!,
            createdby: data['createdby']!,
          ),
        );
      },
    );
  }
}
