import 'package:flutter/material.dart';
import 'package:sharepact_app/screens/home/components/subscription_card.dart';

class RecommendedGrid extends StatelessWidget {
  final List<Map<String, String>> subscriptionData = [
    {
      'service': 'Canva',
      'price': '10,000 NGN',
      'members': '2 slot available',
      'nextpayment': '12/01/2025',
      'createdby': 'JohnDoe1'
    },
    {
      'service': 'Netflix',
      'price': '5,000 NGN',
      'members': '1 slot available',
      'nextpayment': '15/01/2025',
      'createdby': 'JaneDoe2'
    },
    {
      'service': 'Netflix',
      'price': '5,000 NGN',
      'members': '1 slot available',
      'nextpayment': '15/01/2025',
      'createdby': 'JaneDoe2'
    },
    {
      'service': 'Netflix',
      'price': '5,000 NGN',
      'members': '1 slot available',
      'nextpayment': '15/01/2025',
      'createdby': 'JaneDoe2'
    },
   
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
        crossAxisSpacing: 16,
mainAxisSpacing: 5,
        childAspectRatio: 220 / 207, // Adjust the aspect ratio as needed
      ),
      itemCount: subscriptionData.length, // Number of cards
      itemBuilder: (context, index) {
        final data = subscriptionData[index];
        return Opacity(
          opacity: 1.0, // Adjust opacity as needed
          child: SubscriptionCard(
            service: data['service']!,
            price: data['price']!,
            members: data['members']!,
            nextpayment: data['nextpayment']!,
            createdby: data['createdby']!,
            isRecomended: true,
          ),
        );
      },
    );
  }
}

