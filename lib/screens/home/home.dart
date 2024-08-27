import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/categories/listOfCategories.dart';
import 'package:sharepact_app/api/model/subscription/subscription_model.dart';
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
    filterSub = subscriptionModel;
    searchController.addListener(filterMembers);
    Future.microtask(() => getAll());
    // searchController.addListener();
  }

  Future<void> getAll() async {
    final bool isTokenValid =
        await ref.read(profileProvider.notifier).validateToken();
    if (isTokenValid == true) {
      await ref.read(profileProvider.notifier).getUserDetails();
      await ref.read(profileProvider.notifier).getListCategories();
      await ref.read(profileProvider.notifier).getListActiveSub();
      //  final categories = ref.watch(profileProvider).getListCategories;
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
    // final isLoading = ref.watch(profileProvider).getListCategories.isLoading;
    final categories = ref.watch(profileProvider).getListCategories;
    final activeSub = ref.watch(profileProvider).getListActiveSub;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
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
                  child: Text('Error: $e'),
                );
              },
              data: (categories) {
                if (category.isEmpty) {
                  setState(() {
                    category = categories ?? [];
                  });
                }
                return category.isEmpty
                    ? const Center(
                        child: Text("No Active Category"),
                      )
                    : ListView.builder(
                        itemCount: categories?.length,
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
            skipLoadingOnReload: true,
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
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
