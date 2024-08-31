import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/model/categories/categoryByid.dart';
import 'package:sharepact_app/api/model/general_respons_model.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/login.dart';
import 'package:sharepact_app/responsive_widgets.dart';
import 'package:sharepact_app/responsive_helpers.dart';
import 'package:sharepact_app/netflix_details.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';
// Import other screens similarly

class StreamingServicesScreen extends ConsumerStatefulWidget {
  const StreamingServicesScreen({super.key, this.id});
  final String? id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _StreamingServicesScreenState();
}

class _StreamingServicesScreenState
    extends ConsumerState<StreamingServicesScreen> {
  void _navigateToScreen(BuildContext context, String serviceId) {
    print('hu');
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NetflixDetailsScreen(
                id: serviceId,
              )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => getserviceById());
  }

  Future<void> getserviceById() async {
    try {
      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      await ref
          .read(profileProvider.notifier)
          .checkTokenStatus(token: myToken!);
      final isTokenValid = ref.read(profileProvider).checkTokenstatus;

      if (isTokenValid.value!.code == 401) {
        _handleSessionExpired();
        return;
      }
      if (isTokenValid.error != null) {
        final e = isTokenValid.error as GeneralResponseModel;
        showErrorPopup(context: context, message: e.message);
      }
      await _fetchbyId();
    } catch (e) {
      showErrorPopup(context: context, message: e.toString());
    }
  }

  List<Service> ser = [];
  Future<void> _fetchbyId() async {
    try {
      await ref
          .read(profileProvider.notifier)
          .getCategoriesById(id: widget.id!);
      final categories = ref.read(profileProvider).getCategoryById;
      if (categories.value!.code != 200) {
        await getserviceById();
        showErrorPopup(context: context, message: categories.value?.message);
        return;
      }
    } catch (e) {
      // print(e as CategorybyidResponsModel);
      showErrorPopup(context: context, message: e.toString());
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

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(profileProvider).getCategoryById;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categories.hasValue
              ? "${categories.value?.data?.category?.categoryName ?? 'Loading...'} Services"
              : 'Loading... Services',
          style: TextStyle(
            fontSize: responsiveWidth(context, 0.05),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button action
            Navigator.pop(context);
          },
        ),
      ),
      body: ResponsiveContainer(
        child: Column(
          children: [
            SizedBox(height: responsiveHeight(context, 0.02)),
            Expanded(
                child: categories.when(
                    data: (categories) {
                      final v = categories?.data!.services;
                      if (v == null || v.isEmpty) {
                        return Center(
                          child: Text(
                              'No ${categories?.data?.category?.categoryName ?? 'Loading...'} Service'),
                        );
                      }

                      return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: responsiveHeight(context, 0.02),
                            crossAxisSpacing: responsiveHeight(context, 0.02),
                            // mainAxisExtent: 170
                          ),
                          itemCount: v.length,
                          itemBuilder: (context, index) {
                            final item = v[index];

                            return GestureDetector(
                              onTap: () => _navigateToScreen(context, item.id!),
                              child: _buildBorderedResponsiveImageNetwork(
                                  context, item.logoUrl!),
                            );
                          });
                    },
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
                                ref
                                    .read(profileProvider.notifier)
                                    .getCategoriesById(id: widget.id!);
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    },
                    loading: () => Shimmer.fromColors(
                        baseColor: AppColors.accent,
                        highlightColor: AppColors.primaryColor,
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: responsiveWidth(context, 0.04),
                          mainAxisSpacing: responsiveHeight(context, 0.02),
                          children: [
                            'assets/netflix.png',
                            'assets/primevideo.png',
                            'assets/showmax.png',
                            'assets/hulu.png',
                            'assets/disney.png',
                            'assets/hbo.png',
                            'assets/paramount.png',
                          ].map((imagePath) {
                            return GestureDetector(
                              onTap: () {},
                              child: _buildBorderedResponsiveImage(
                                  context, imagePath),
                            );
                          }).toList(),
                        )))),
          ],
        ),
      ),
    );
  }

  Widget _buildBorderedResponsiveImage(BuildContext context, String imagePath) {
    return Container(
      width: responsiveWidth(context, 0.4),
      height: responsiveHeight(context, 0.25),
      padding: EdgeInsets.all(responsiveWidth(context, 0.08)),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD1D4D7), width: 1.0),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        ),
      ),
      child: ResponsiveImage(
        imagePath: imagePath,
        heightFactor: 0.1,
        widthFactor: 0.1,
      ),
    );
  }

  Widget _buildBorderedResponsiveImageNetwork(
      BuildContext context, String imagePath) {
    return Container(
      width: responsiveWidth(context, 0.4),
      height: responsiveHeight(context, 0.25),
      padding: EdgeInsets.all(responsiveWidth(context, 0.08)),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffD1D4D7), width: 1.0),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(0.0),
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
        ),
      ),
      child: ResponsiveImageNetwork(
        imagePath: imagePath,
        heightFactor: 0.1,
        widthFactor: 0.1,
      ),
    );
  }
}
