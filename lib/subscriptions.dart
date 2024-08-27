// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/login.dart';
import 'package:sharepact_app/screens/home/components/subscription_card.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class SubscriptionsScreen extends ConsumerStatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends ConsumerState<SubscriptionsScreen> {
  TextEditingController searchController = TextEditingController();
  List<SubscriptionModel> filterSub = [];
  List<SubscriptionModel> subscriptionModel = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterSub = subscriptionModel;
    searchController.addListener(filterMembers);
    Future.microtask(() => getAll());
    // searchController.addListener();
  }

  Future<void> getAll() async {
    final bool isTokenValid =
        await ref.read(profileProvider.notifier).validateToken();
    if (isTokenValid == true) {
      await ref.read(profileProvider.notifier).getListActiveSub();
      final categories = ref.watch(profileProvider).getListActiveSub;
      print(categories.value);
    } else {
      if (mounted) {
        showErrorPopup(context: context, message: 'Session Expired');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
      //      final isLoading = ref.watch(profileProvider).fetchSubcription.isLoading;
      // final currentPlan =
      //     ref.watch(profileProvider).fetchSubcription.sureValue?.plan;
    }
  }

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
  void filterMembers() {
    final filter = searchController.text.toLowerCase();
    setState(() {
      filterSub = subscriptionModel.where((member) {
        final groupName = (member.groupName ?? '').toLowerCase();
        final planName = (member.planName ?? '').toLowerCase();

        return planName.contains(filter) || groupName.contains(filter);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeSub = ref.watch(profileProvider).getListActiveSub;
    return Padding(
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
                Expanded(
                  child: TextField(
                    controller: searchController,
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
          activeSub.when(
            loading: () => Shimmer.fromColors(
              baseColor: AppColors.accent,
              highlightColor: AppColors.primaryColor,
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 12,
                    mainAxisExtent: 170),
                itemCount: subscriptionData.length,
                itemBuilder: (context, index) {
                  final data = subscriptionData[index];
                  return Opacity(
                    opacity: 1.0,
                    child: SubscriptionCard(
                      service: data['service']!,
                      price: 10,
                      members: 3,
                      nextpayment: data['nextpayment']!,
                      createdby: data['createdby']!,
                    ),
                  );
                },
              ),
            ),
            error: (
              error,
              stackTrace,
            ) {
              print({error, stackTrace});
              return Center(child: Text(error.toString()));
            },
            data: (activeSub) {
              if (subscriptionModel.isEmpty) {
                setState(() {
                  subscriptionModel = activeSub ?? [];
                  filterSub = subscriptionModel;
                });
              }
              return subscriptionModel.isEmpty
                  ? const Center(child: Text('No Active Subscription'))
                  : filterSub.isEmpty
                      ? Center(
                          child: Text(
                              'No Result Found: "${searchController.text}"'))
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 12,
                                  mainAxisExtent: 170),
                          itemCount: filterSub.length,
                          itemBuilder: (context, index) {
                            final item = filterSub[index];

                            return Opacity(
                              opacity: 1.0,
                              child: SubscriptionCard(
                                service: item.planName,
                                price: item.totalCost,
                                members: item.numberOfMembers,
                                nextpayment: '',
                                createdby: item.groupName,
                              ),
                            );
                          },
                        );
            },
          ),
        ],
      ),
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
          icon: const Icon(Icons.arrow_drop_down,
              color: Colors.grey), // Dropdown arrow
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((String item) {
              return Row(
                children: [
                  const Icon(Icons.filter_list,
                      color: Colors.grey), // Filter icon
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
