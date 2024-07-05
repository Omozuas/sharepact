// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:sharepact_app/screens/home/components/subscription_card.dart';

class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Subscriptions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    'assets/search.png', // Replace with actual image path
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
            const SizedBox(height: 16),
                       Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 12, // Number of cards to display
                itemBuilder: (context, index) {
                  return const SubscriptionCard(
                    service: 'Netflix',
                    price: '10,000 NGN',
                    members: '5/5 members',
                    nextpayment: '12/01/25',
                    createdby: 'JohnDoe1',
                  );
                },
              ),
            ),
          ],
        ),
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
}

class _CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;

  const _CustomDropdown({
    super.key,
    required this.value,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {},
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey), // Dropdown arrow
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              return Row(
                children: [
                  const Icon(Icons.filter_list, color: Colors.grey), // Filter icon
                  const SizedBox(width: 8),
                  Text(item),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
