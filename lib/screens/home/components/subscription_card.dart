import 'package:flutter/material.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';

class SubscriptionCard extends StatelessWidget {
  final String? service;
  final price;
  final members;
  final currentMembers;
  final String? nextpayment;
  final String? createdby;
  final Widget? image, profile, profile1;
  const SubscriptionCard(
      {super.key,
      this.service,
      this.price,
      this.members,
      this.nextpayment,
      this.createdby,
      this.profile,
      this.currentMembers,
      this.profile1,
      this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163,
      height: 187,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        border: Border.all(width: 1, color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: const BoxDecoration(
              color: AppColors.lightBlue01,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                image ??
                    Image.asset(
                      AppImages
                          .avatarImage5, // Replace with actual image URL or asset
                      width: 16,
                      height: 16,
                    ),
                const SizedBox(width: 8),
                Text(
                  'Created by : $createdby',
                  softWrap: true,
                  style:
                      const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                profile ??
                    Image.asset(
                      "assets/profile.png",
                      width: 24,
                      height: 24,
                    ),
                const SizedBox(width: 8),
                Text(
                  "$service",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: RichText(
              text: TextSpan(
                text: "$price NGN",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
                children: const [
                  TextSpan(
                    text: ' / month',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                profile1 ??
                    Image.asset(
                      'assets/profile.png', // Replace with the actual path to the members image
                      width: 16,
                      height: 16,
                    ),
                const SizedBox(width: 4),
                Text(
                  "$currentMembers/ $members members",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          // const Spacer(), // Add a Spacer to push the button to the bottom

          Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 28,
            padding: const EdgeInsets.symmetric(horizontal: 13),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0XFFD1D4D7))),
            ),
            child: Text(
              'Next payment: $nextpayment ',
              style: const TextStyle(fontSize: 8, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
