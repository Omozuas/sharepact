import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
import 'package:sharepact_app/api/model/user/user_model.dart';
import 'package:sharepact_app/api/riverPod/categoryProvider.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/subscriptionProvider.dart';
import 'package:sharepact_app/api/riverPod/userProvider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/screens/home/components/service_widget.dart';
import 'package:sharepact_app/screens/home/components/subscription_card.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
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
    super.initState();
    // filterSub = subscriptionModel;
    searchController.addListener(filterMembers);
    Future.microtask(() => getAll());
  }

  Future<void> getAll() async {
    try {
      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      await ref
          .read(profileProvider.notifier)
          .checkTokenStatus(token: myToken!);
      final isTokenValid = ref.read(profileProvider).checkTokenstatus.value;
      if (isTokenValid?.code != 200) {
        _handleSessionExpired();
        return;
      }
      // await _fetchUserData();
      await _fetchCategories();
      await _fetchActiveSubscriptions();
    } catch (e) {
      // final e1 = e as UserResponseModel;
      _handleError(e.toString());
    }
  }

  // Future<void> _fetchUserData() async {
  //   await ref.read(profileProvider.notifier).getUserDetails();
  //   final user = ref.watch(profileProvider).getUser;
  //   if (user.error != null) {
  //     _handleError(user.error.toString());
  //     return;
  //   }
  // }

  Future<void> _fetchCategories() async {
    await ref.read(categoryProvider.notifier).getListCategories();
    final categories = ref.watch(categoryProvider);

    if (categories.hasValue) {
      if (categories.error == null) {
        category = categories.value!;
        return;
      } else {
        category = [];
        return;
      }
    } else {
      final e = categories.error as UserResponseModel;
      _handleError(e.message.toString());
    }
  }

  void _handleError([String? message]) {
    if (mounted) {
      showErrorPopup(context: context, message: message);
      return;
    }
  }

  Future<void> _fetchActiveSubscriptions() async {
    await ref.read(subscriptionProvider.notifier).getListActiveSub();
    final activeSub = ref.watch(subscriptionProvider);

    if (activeSub.error == null) {
      if (activeSub.hasValue) {
        subscriptionModel = activeSub.value!;
        filterSub = activeSub.value!;
      } else {
        subscriptionModel = [];
      }
    } else {
      final e = activeSub.error as UserResponseModel;
      _handleError(e.message.toString());
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

  void handleUnexpectedError(Object e, StackTrace stackTrace) {
    if (mounted) {
      // print('Unexpected Error: $e');
      // print('StackTrace: $stackTrace');
      showErrorPopup(
          context: context, message: 'An unexpected error occurred.');
    }
  }

  void filterMembers() {
    final filter = searchController.text.trim().toLowerCase();
    setState(() {
      filterSub = subscriptionModel.where((member) {
        final groupName = (member.groupName ?? '').toLowerCase();

        final adminName = (member.service?.serviceName ?? '').toLowerCase();

        return groupName.contains(filter) || adminName.contains(filter);
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
    final categories = ref.watch(categoryProvider);
    final activeSub = ref.watch(subscriptionProvider);
    ref.watch(profileProvider).checkTokenstatus;
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: () async {
          getAll();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  skipLoadingOnReload: true,
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
                    return Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          // final item = categories!.data![index];
                          return ServiceWidget(
                            title: 'loading...',
                            imgaeURL: const AssetImage('assets/sphere.png'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const StreamingServicesScreen()));
                            },
                            backgroundColor: AppColors.lightBlue,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  },
                  data: (categories) {
                    return categories == null
                        ? const Center(
                            child: Text("No Active Category"),
                          )
                        : ListView.builder(
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              final item = categories[index];

                              return ServiceWidget(
                                imgaeURL: NetworkImage('${item.imageUrl}'),
                                title: '${item.categoryName}',
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          StreamingServicesScreen(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "My Subscriptions",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ControllerNavScreen(
                                    initialIndex: 1,
                                  )));
                    },
                    child: const Text(
                      "Show All",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 18,
                            crossAxisSpacing: 12,
                            mainAxisExtent: 170),
                    itemCount: 6,
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
                error: (
                  e,
                  stackTrace,
                ) {
                  final el = e as UserResponseModel;
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
                          ref.read(userProvider.notifier).getUserDetails();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  );
                },
                // skipLoadingOnReload: true,
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
                              itemCount:
                                  filterSub.length > 6 ? 6 : filterSub.length,
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
                                    nextpayment: item.nextSubscriptionDate
                                                .toString() ==
                                            'null'
                                        ? ''
                                        : DateFormat('d MMM y')
                                            .format(item.nextSubscriptionDate!)
                                            .toString(),
                                    createdby: item.admin?.username,
                                    currentMembers:
                                        item.members?.length.toString(),
                                  ),
                                );
                              },
                            );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
