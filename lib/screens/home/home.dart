import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/login.dart';
import 'package:sharepact_app/screens/home/components/service_widget.dart';
import 'package:sharepact_app/screens/home/components/subscription_card.dart';
import 'package:sharepact_app/screens/home/header.dart';
import 'package:sharepact_app/streaming_services.dart'; // Import the StreamingServicesScreen
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';
// Import MySubscriptionsScreen

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<SubscriptionModel> filterSub = [];
  List<SubscriptionModel> subscriptionModel = [];
  List<CategoriesModel> category = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // filterSub = subscriptionModel;
    searchController.addListener(filterMembers);
    Future.microtask(() => getAll());
  }

  Future<void> getAll() async {
    try {
      final isTokenValid =
          await ref.read(profileProvider.notifier).validateToken();

      if (!isTokenValid) {
        _handleSessionExpired();
        return;
      }

      await _fetchUserData();
      await _fetchCategories();
      await _fetchActiveSubscriptions();
    } catch (e, stackTrace) {
      _handleUnexpectedError(e, stackTrace);
    }
  }

  Future<void> _fetchUserData() async {
    await ref.read(profileProvider.notifier).getUserDetails();
    final user = ref.watch(profileProvider).getUser.value;
    if (user?.code != 200) {
      _handleError(user?.message, user?.code);
      return;
    }
  }

  Future<void> _fetchCategories() async {
    await ref.read(profileProvider.notifier).getListCategories();
    final categories = ref.watch(profileProvider).getListCategories.value;

    if (categories?.code == 200) {
      if (categories?.data != null) {
        category = categories!.data!;
        return;
      } else {
        category = [];
        return;
      }
    } else {
      _handleError(categories?.message, categories?.code);
    }
  }

  void _handleError(String? message, int? code) {
    if (code != 200 && mounted) {
      showErrorPopup(context: context, message: message);
      return;
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
    // final isLoading = ref.watch(profileProvider).getListCategories.isLoading;
    final categories = ref.watch(profileProvider).getListCategories;
    final activeSub = ref.watch(profileProvider).getListActiveSub;
    final getUser = ref.watch(profileProvider).getUser;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(userModel: getUser.value?.data),
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
          const SizedBox(height: 20),
          const Text(
            'Available Categories',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 110,
            child: categories.when(
              loading: () => Shimmer.fromColors(
                baseColor: AppColors.accent,
                highlightColor: AppColors.primaryColor,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    // final item = categories!.data![index];
                    return ServiceWidget(
                      title: 'Streaming',
                      imgaeURL: const AssetImage('assets/sphere.png'),
                      onTap: () {},
                      backgroundColor: AppColors.lightBlue,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              error: (e, st) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Error loading categories: $e'),
                      ElevatedButton(
                        onPressed: () {
                          // Add retry logic here
                          ref
                              .read(profileProvider.notifier)
                              .getListCategories();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              },
              data: (categories) {
                return category.isEmpty
                    ? const Center(
                        child: Text("No Active Category"),
                      )
                    : ListView.builder(
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          final item = category[index];

                          return ServiceWidget(
                            imgaeURL: NetworkImage('${item.imageUrl}'),
                            title: '${item.categoryName}',
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StreamingServicesScreen(
                                        id: item.id,
                                      )),
                            ),
                            backgroundColor: AppColors.lightBlue,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      );
              },
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
                style: TextStyle(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline),
              )
            ],
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
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Opacity(
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
            error: (
              e,
              stackTrace,
            ) {
              print('Error loading subscriptions: $e');
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Error loading subscriptions: $e'),
                    ElevatedButton(
                      onPressed: () {
                        // Add retry logic here
                        ref.read(profileProvider.notifier).getListActiveSub();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            },
            // skipLoadingOnReload: true,
            data: (activeSub) {
              if (subscriptionModel.isEmpty) {
                setState(() {
                  subscriptionModel = activeSub?.data ?? [];
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
                          itemCount:
                              filterSub.length > 6 ? 6 : filterSub.length,
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
