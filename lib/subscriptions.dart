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
    try {
      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      await ref
          .read(profileProvider.notifier)
          .checkTokenStatus(token: myToken!);
      final isTokenValid = ref.read(profileProvider).checkTokenstatus.value;

      if (isTokenValid!.code != 200) {
        _handleSessionExpired();
        return;
      }
      await _fetchActiveSubscriptions();
    } catch (e, stackTrace) {
      _handleUnexpectedError(e, stackTrace);
    }
  }

  Future<void> _fetchActiveSubscriptions() async {
    await ref.read(profileProvider.notifier).getListActiveSub();
    final activeSub = ref.watch(profileProvider).getListActiveSub.value;

    if (activeSub?.code == 200) {
      if (activeSub?.data != null) {
        subscriptionModel = activeSub!.data!;
        filterSub = activeSub.data!;
      } else {
        subscriptionModel = [];
      }
    } else {
      _handleError(activeSub?.message, activeSub?.code);
    }
  }

  void _handleError(String? message, int? code) {
    if (code != 200 && mounted) {
      showErrorPopup(context: context, message: message);
      return;
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

  void _handleUnexpectedError(Object e, StackTrace stackTrace) {
    if (mounted) {
      print('Unexpected Error: $e');
      print('StackTrace: $stackTrace');
      showErrorPopup(
          context: context, message: 'An unexpected error occurred.');
    }
  }

  void filterMembers() {
    final filter = searchController.text.toLowerCase();
    setState(() {
      filterSub = subscriptionModel.where((member) {
        final groupName = (member.groupName ?? '').toLowerCase();
        final planName = (member.planName ?? '').toLowerCase();
        final adminName = (member.admin?.username ?? '').toLowerCase();

        return planName.contains(filter) ||
            groupName.contains(filter) ||
            adminName.contains(filter);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Opacity(
                    opacity: 1.0,
                    child: SubscriptionCard(
                      service: ' loading...',
                      price: 10,
                      members: 3,
                      nextpayment: '',
                      createdby: ' ',
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
                  subscriptionModel = activeSub?.data ?? [];
                  filterSub = subscriptionModel;
                  print(filterSub);
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
                                image: Image.network(
                                  '${item.admin!.avatarUrl}', // Replace with the actual path to the members image
                                  width: 16,
                                  height: 16,
                                ),
                                profile: Image.network(
                                  '${item.service!.logoUrl}', // Replace with the actual path to the members image
                                  width: 16,
                                  height: 16,
                                ),
                                profile1: Image.network(
                                  '${item.admin!.avatarUrl}', // Replace with the actual path to the members image
                                  width: 16,
                                  height: 16,
                                ),
                                service: item.service!.serviceName,
                                price: item.totalCost,
                                members: item.numberOfMembers,
                                nextpayment: '',
                                createdby: item.admin!.username,
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
