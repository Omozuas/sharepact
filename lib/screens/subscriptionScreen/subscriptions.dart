// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';
import 'package:sharepact_app/api/riverPod/categoryProvider.dart';
import 'package:sharepact_app/api/riverPod/group_list.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/subscription_provider.dart';
import 'package:sharepact_app/api/riverPod/user_provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
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

  int page = 10;
  @override
  void initState() {
    super.initState();
    searchController.addListener(filterMembers);
    Future.microtask(() => getAll());
    // searchController.addListener();
    _scrollController = ScrollController()
      ..addListener(() {
        // Trigger when the user scrolls to the bottom
        if (loaging) return;
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            loaging = true;
          });
          page = page + 10;
          ref.read(subscriptionProvider.notifier).getListActiveSub(limit: page);
          filterMembers();
          setState(() {
            loaging = false;
          });
        }
      });
  }

  Future<void> getAll() async {
    try {
      await ref.read(profileProvider.notifier).validateToken();
      final isTokenValid = ref.read(profileProvider).isTokenValid.value;
      if (isTokenValid == false) {
        _handleSessionExpired();
        return;
      }
      await _fetchActiveSubscriptions();
    } catch (e) {
      _handleUnexpectedError(e);
    }
  }

  Future<void> _fetchActiveSubscriptions() async {
    await ref.read(subscriptionProvider.notifier).getListActiveSub(limit: page);
    final activeSub = ref.watch(subscriptionProvider);

    if (activeSub.error == null && activeSub.hasValue) {
      setState(() {
        filterSub = activeSub.value!;
      });
    } else if (activeSub.error != null) {
      final e = activeSub.error as UserResponseModel;
      _handleError(e.message.toString());
    }
  }

  void _handleError(
    String? message,
  ) {
    showErrorPopup(context: context, message: message);
    return;
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

  void _handleUnexpectedError(e) {
    if (mounted) {
      showErrorPopup(context: context, message: e.toString());
    }
  }

  void filterMembers() {
    final filter = searchController.text.trim().toLowerCase();
    final subscriptions = ref.watch(subscriptionProvider).value;
    if (subscriptions != null) {
      setState(() {
        filterSub = subscriptions.where((member) {
          final groupName = (member.groupName ?? '').toLowerCase();
          final adminName = (member.service?.serviceName ?? '').toLowerCase();

          return groupName.contains(filter) || adminName.contains(filter);
        }).toList();
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  late final ScrollController _scrollController;
  bool loaging = false;
  @override
  Widget build(BuildContext context) {
    final activeSub = ref.watch(subscriptionProvider);
    ref.watch(userProvider);
    ref.watch(categoryProvider);
    ref.watch(profileProvider).checkTokenstatus;
    ref.watch(groupListprovider);
    final isloading = ref.watch(subscriptionProvider).isLoading;
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
      child: RefreshIndicator(
        onRefresh: () async {
          await getAll();
        },
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
                      decoration: const InputDecoration(
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
              skipLoadingOnReload: true,
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
                    return const Opacity(
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
                final el = error as UserResponseModel;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 18,
                                crossAxisSpacing: 12,
                                mainAxisExtent: 170),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return const Opacity(
                            opacity: 1.0,
                            child: SubscriptionCard(
                              service: 'loading...',
                              price: 10,
                              members: 3,
                              nextpayment: '',
                              createdby: '',
                            ),
                          );
                        },
                      ),
                    ),
                    Text('Error loading subscriptions: ${el.message}'),
                    ElevatedButton(
                      onPressed: () {
                        // Add retry logic here
                        getAll();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                );
              },
              data: (activeSub) {
                if (searchController.text.isEmpty) {
                  setState(() {
                    filterSub = activeSub ?? [];
                  });
                } else {
                  filterMembers(); // Apply filter based on the current search term
                }
                if (activeSub!.isEmpty) {
                  return Center(
                    heightFactor: 1.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Lottie.asset("assets/empty.json"),
                        Text(
                          "No Active Subscripton yet",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "You're all caught up! No Active Subscripton at the moment. Check back later for updates",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return filterSub.isEmpty
                    ? Center(
                        child:
                            Text('No Result Found: "${searchController.text}"'))
                    : Expanded(
                        child: GridView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          // physics: const A
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 12,
                                  mainAxisExtent: 170),
                          itemCount: loaging
                              ? filterSub.length + 10
                              : filterSub.length,
                          itemBuilder: (context, index) {
                            final item = filterSub[index];
                            return Opacity(
                              opacity: 1.0,
                              child: SubscriptionCard(
                                image: Image.network(
                                  '${item.admin?.avatarUrl}', // Replace with the actual path to the members image
                                  width: 16,
                                  height: 16,
                                ),
                                profile: Image.network(
                                  '${item.service?.logoUrl}', // Replace with the actual path to the members image
                                  width: 16,
                                  height: 16,
                                ),
                                profile1: Image.network(
                                  '${item.admin?.avatarUrl}', // Replace with the actual path to the members image
                                  width: 16,
                                  height: 16,
                                ),
                                service: item.groupName,
                                price: item.subscriptionCost,
                                members: item.numberOfMembers,
                                nextpayment:
                                    item.nextSubscriptionDate.toString() ==
                                            'null'
                                        ? ''
                                        : DateFormat('d MMM y')
                                            .format(item.nextSubscriptionDate!)
                                            .toString(),
                                createdby: item.admin!.username,
                                currentMembers: item.members?.length.toString(),
                              ),
                            );
                          },
                        ),
                      );
              },
            ),
            isloading
                ? const Center(child: CircularProgressIndicator())
                : Container()
          ],
        ),
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
