import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/userProvider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/login.dart';
import 'package:sharepact_app/providers/settings_provider.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class ChangeAvatarScreen extends ConsumerStatefulWidget {
  const ChangeAvatarScreen({super.key});

  @override
  ConsumerState createState() => _ChangeAvatarScreenState();
}

class _ChangeAvatarScreenState extends ConsumerState<ChangeAvatarScreen> {
  List<String>? avaters1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => _fetechAlAvaters());
  }

  Future<void> _fetechAlAvaters() async {
    await ref.read(profileProvider.notifier).getToken();
    final myToken = ref.read(profileProvider).getToken.value;
    await ref.read(profileProvider.notifier).checkTokenStatus(token: myToken!);
    final isTokenValid = ref.read(profileProvider).checkTokenstatus;
    if (isTokenValid.value!.code != 200) {
      _handleSessionExpired();
      return;
    }
    await ref.read(profileProvider.notifier).getAllAvater();
    final allAvaters = ref.read(profileProvider).getAllAvater.value;
    if (allAvaters?.code != 200) {
      _handleError(allAvaters?.message, allAvaters?.code);
      return;
    } else {
      setState(() {
        avaters1 = allAvaters!.data?.avatars;
      });
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

  void _handleError(String? message, int? code) {
    if (code != 200 && mounted) {
      showErrorPopup(context: context, message: message);
      return;
    }
  }

  Future<void> update() async {
    await ref.read(profileProvider.notifier).getToken();
    final myToken = ref.read(profileProvider).getToken.value;
    await ref.read(profileProvider.notifier).checkTokenStatus(token: myToken!);
    final isTokenValid = ref.read(profileProvider).checkTokenstatus.value;

    if (isTokenValid!.code == 401) {
      _handleSessionExpired();
      return;
    }
    var avatarIndex = ref.watch(avatarProvider);

    if (avaters1 != null && avatarIndex < avaters1!.length) {
      try {
        await ref
            .read(profileProvider.notifier)
            .updatAvater(avaterUrl: avaters1![avatarIndex]);

        final pUpdater = ref.read(profileProvider).updateAvater;
        if (mounted) {
          if (pUpdater.value != null) {
            // Safely access message
            final message = pUpdater.value?.message;

            // Check if the response code is 200
            if (pUpdater.value!.code == 200) {
              showSuccess(message: message!, context: context);
              _fetechAlAvaters();
              await ref.read(userProvider.notifier).getUserDetails();
            } else {
              showErrorPopup(message: message, context: context);
            }
          }
        }
      } catch (er) {
        // Show error if login fails
        if (mounted) {
          showErrorPopup(
              message: er.toString().replaceAll('Exception: ', ''),
              context: context);
        }
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final isLoading = ref.watch(profileProvider).updateAvater.isLoading;
    var avatarIndex = ref.watch(avatarProvider);
    final all = ref.read(profileProvider).getAllAvater;

    return Scaffold(
      backgroundColor: AppColors.skyBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: double.infinity,
                  child: Stack(fit: StackFit.expand, children: [
                    all.when(
                        data: (data) {
                          if (avaters1 != null &&
                              avatarIndex < avaters1!.length) {
                            return Image.network(
                              avaters1![avatarIndex],
                              fit: BoxFit.cover,
                            );
                          }

                          return Shimmer.fromColors(
                            baseColor: AppColors.accent,
                            highlightColor: AppColors.primaryColor,
                            child: Image.asset(
                              'assets/avatars/image6.png',
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        error: (e, st) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Error loading avatars: $e'),
                                ElevatedButton(
                                  onPressed: _fetechAlAvaters,
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        },
                        loading: () => Shimmer.fromColors(
                              baseColor: AppColors.accent,
                              highlightColor: AppColors.primaryColor,
                              child: Image.asset(
                                'assets/avatars/image6.png',
                                fit: BoxFit.cover,
                              ),
                            )),
                    Positioned(
                      top: 20,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () async {
                                  Navigator.pop(context);
                                  ref
                                      .read(userProvider.notifier)
                                      .getUserDetails();
                                },
                                child: Icon(Icons.arrow_back_ios)),
                            Text(
                              "Change Avatar",
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.70,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(64),
                      topRight: Radius.circular(64),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      all.when(
                          loading: () => Shimmer.fromColors(
                                baseColor: AppColors.accent,
                                highlightColor: AppColors.primaryColor,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 20.0,
                                    crossAxisSpacing: 20,
                                    crossAxisCount: 3,
                                  ),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: allAvatars.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        ref
                                            .read(avatarProvider.notifier)
                                            .state = index;
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            border: avatarIndex == index
                                                ? Border.all(
                                                    width: 4,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )
                                                : null,
                                            shape: BoxShape.circle),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            allAvatars[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
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
                                          .getAllAvater();
                                    },
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            );
                          },
                          data: (all) {
                            if (avaters1 == null) {
                              return Shimmer.fromColors(
                                baseColor: AppColors.accent,
                                highlightColor: AppColors.primaryColor,
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 20.0,
                                    crossAxisSpacing: 20,
                                    crossAxisCount: 3,
                                  ),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8.0),
                                  itemCount: allAvatars.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        ref
                                            .read(avatarProvider.notifier)
                                            .state = index;
                                      },
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            border: avatarIndex == index
                                                ? Border.all(
                                                    width: 4,
                                                    color:
                                                        AppColors.primaryColor,
                                                  )
                                                : null,
                                            shape: BoxShape.circle),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.asset(
                                            allAvatars[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 20.0,
                                crossAxisSpacing: 20,
                                crossAxisCount: 3,
                              ),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(8.0),
                              itemCount: avaters1?.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    ref.read(avatarProvider.notifier).state =
                                        index;
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        border: avatarIndex == index
                                            ? Border.all(
                                                width: 4,
                                                color: AppColors.primaryColor,
                                              )
                                            : null,
                                        shape: BoxShape.circle),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        avaters1![index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 59,
                        child: ElevatedButton(
                          onPressed: isLoading ? () {} : update,
                          child: isLoading
                              ? const CircularProgressIndicator()
                              : const Text('Update Avatar'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
