import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/api/model/notificationmodel.dart';
import 'package:sharepact_app/api/riverPod/chat2_provider.dart';
import 'package:sharepact_app/api/riverPod/chat_provider.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/settingsN/otification.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/widgets/checkbox_row.dart';
import 'package:shimmer/shimmer.dart';
import '../../responsive_helpers.dart';

class NotificationSettings extends ConsumerStatefulWidget {
  const NotificationSettings({super.key});

  @override
  ConsumerState createState() => NotificationSettingsState();
}

class NotificationSettingsState extends ConsumerState<NotificationSettings> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => _get());
  }

  bool loginAlert = false;
  bool passwordChanges = false;
  bool newGroupCreation = false;
  bool groupInvitation = false;
  bool groupMessages = false;
  bool subscriptionUpdates = false;
  bool paymentReminders = false;
  bool renewalAlerts = false;
  void _handleSessionExpired() {
    if (mounted) {
      showErrorPopup(message: 'Session expired', context: context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  Future<void> postdetils() async {
    await ref.read(profileProvider.notifier).validateToken();
    final isTokenValid = ref.read(profileProvider).isTokenValid.value;
    if (isTokenValid == false) {
      _handleSessionExpired();
      return;
    }
    try {
      await ref.read(profileProvider.notifier).patchMotificationSettings(
          loginAlert: loginAlert,
          passwordChanges: passwordChanges,
          newGroupCreation: newGroupCreation,
          groupInvitation: groupInvitation,
          groupMessages: groupMessages,
          subscriptionUpdates: subscriptionUpdates,
          paymentReminders: paymentReminders,
          renewalAlerts: renewalAlerts);

      final pUpdater = ref.read(profileProvider).motificationSettings;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful

            showSuccess(message: message!, context: context);
          } else {
            showErrorPopup(message: message, context: context);
          }
        }
      }
    } catch (e) {
      // Show error if login fails
      if (mounted) {
        showErrorPopup(
            message: e.toString().replaceAll('Exception: ', ''),
            context: context);
      }
    }
  }

  Future<void> _get() async {
    await ref.read(notificationConfigProvider.notifier).getNotificationConfig();
    final pUpdater = ref.watch(notificationConfigProvider);
    // Navigate to home screen if login is successful
    if (pUpdater.hasValue) {
      if (pUpdater.error == null) {}
    }
    if (mounted) {
      if (pUpdater.value != null) {
        // Safely access message
        final message = pUpdater.value?.message;
        final item = pUpdater.value?.data;
        // Check if the response code is 200
        if (pUpdater.value!.code == 200) {
          // Navigate to homescreen if signin is successful
          if (item != null) {
            setState(() {
              groupInvitation = item.groupInvitation!;
              groupMessages = item.groupMessages!;
              renewalAlerts = item.renewalAlerts!;
              loginAlert = item.loginAlert!;
              paymentReminders = item.paymentReminders!;
              passwordChanges = item.passwordChanges!;
              newGroupCreation = item.newGroupCreation!;
              subscriptionUpdates = item.subscriptionUpdates!;
            });
          }

          // showSuccess(message: message!, context: context);
          return;
        } else {
          showErrorPopup(message: message, context: context);
          return;
        }
      }
    }
  }
  // Show error if login fails

  @override
  Widget build(BuildContext context) {
    final nitificationSetting = ref.watch(notificationConfigProvider);
    final isLoading = ref.watch(profileProvider).motificationSettings.isLoading;
    ref.watch(chatStateProvider);
    ref.watch(chatProvider1);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notifications",
          style: GoogleFonts.lato(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
          child: nitificationSetting.when(
              skipLoadingOnReload: true,
              loading: () => Shimmer.fromColors(
                    baseColor: AppColors.accent,
                    highlightColor: AppColors.primaryColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Customize your notification preferences to stay updated with what\'s important. Manage alerts for your account, groups, subscriptions',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff5D6166),
                                  ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Account Notifications',
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CheckboxRow(
                                text: 'Login Alerts',
                                provider: false,
                                onChanged: (value) {
                                  //  = value!;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CheckboxRow(
                                text: 'Password Changes',
                                provider: false,
                                onChanged: (value) {
                                  //  = value!;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Group Notifications',
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CheckboxRow(
                                text: 'New Group Creation',
                                provider: false,
                                onChanged: (value) {
                                  //  = value!;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CheckboxRow(
                                text: 'Invitations',
                                provider: false,
                                onChanged: (value) {
                                  //  = value!;
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CheckboxRow(
                                text: 'Messages',
                                provider: false,
                                onChanged: (value) {
                                  //  = value!;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Subscription Notifications',
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CheckboxRow(
                                text: 'Subscription Updates',
                                provider: false,
                                onChanged: (value) {
                                  //  = value!;
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CheckboxRow(
                                text: 'Payment Reminders',
                                onChanged: (value) {
                                  //  = value!;
                                },
                                provider: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CheckboxRow(
                                text: 'Renewal Alerts',
                                onChanged: (value) {
                                  //  = value!;
                                },
                                provider: false,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: responsiveHeight(context, 0.08),
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Save Changes'),
                          ),
                        ),
                        SizedBox(height: responsiveHeight(context, 0.01)),
                      ],
                    ),
                  ),
              error: (error, stackTrace) {
                final err = error as NotificationConfigResponse;
                return Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: AppColors.accent,
                      highlightColor: AppColors.primaryColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Customize your notification preferences to stay updated with what\'s important. Manage alerts for your account, groups, subscriptions',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff5D6166),
                                ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Account Notifications',
                                  style: GoogleFonts.lato(
                                    color: AppColors.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CheckboxRow(
                                  text: 'Login Alerts',
                                  provider: false,
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CheckboxRow(
                                  text: 'Password Changes',
                                  provider: false,
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Group Notifications',
                                  style: GoogleFonts.lato(
                                    color: AppColors.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CheckboxRow(
                                  text: 'New Group Creation',
                                  provider: false,
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CheckboxRow(
                                  text: 'Invitations',
                                  provider: false,
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CheckboxRow(
                                  text: 'Messages',
                                  provider: false,
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Subscription Notifications',
                                  style: GoogleFonts.lato(
                                    color: AppColors.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CheckboxRow(
                                  text: 'Subscription Updates',
                                  provider: false,
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CheckboxRow(
                                  text: 'Payment Reminders',
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                  provider: false,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CheckboxRow(
                                  text: 'Renewal Alerts',
                                  onChanged: (value) {
                                    //  = value!;
                                  },
                                  provider: false,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: responsiveHeight(context, 0.08),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Save Changes'),
                            ),
                          ),
                          SizedBox(height: responsiveHeight(context, 0.01)),
                        ],
                      ),
                    ),
                    Text(
                      '${err.message}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff5D6166),
                          ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add retry logic here
                        _get();
                        ref
                            .read(notificationConfigProvider.notifier)
                            .getNotificationConfig();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                );
              },
              data: (nitificationSetting) {
                final item = nitificationSetting?.data;
                if (item != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Customize your notification preferences to stay updated with what\'s important. Manage alerts for your account, groups, subscriptions',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff5D6166),
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Notifications',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Login Alerts',
                              provider: loginAlert,
                              onChanged: (value) {
                                setState(() {
                                  loginAlert = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Password Changes',
                              provider: passwordChanges,
                              onChanged: (value) {
                                setState(() {
                                  passwordChanges = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Group Notifications',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'New Group Creation',
                              provider: newGroupCreation,
                              onChanged: (value) {
                                setState(() {
                                  newGroupCreation = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Invitations',
                              provider: groupInvitation,
                              onChanged: (value) {
                                setState(() {
                                  groupInvitation = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Messages',
                              provider: groupMessages,
                              onChanged: (value) {
                                setState(() {
                                  groupMessages = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subscription Notifications',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'Subscription Updates',
                              provider: subscriptionUpdates,
                              onChanged: (value) {
                                setState(() {
                                  subscriptionUpdates = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'Payment Reminders',
                              onChanged: (value) {
                                setState(() {
                                  paymentReminders = value!;
                                });
                              },
                              provider: paymentReminders,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'Renewal Alerts',
                              onChanged: (value) {
                                setState(() {
                                  renewalAlerts = value!;
                                });
                              },
                              provider: renewalAlerts,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: responsiveHeight(context, 0.08),
                        child: ElevatedButton(
                          onPressed: isLoading ? () {} : postdetils,
                          child: isLoading
                              ? const Text('Saving... Changes')
                              : const Text('Save Changes'),
                        ),
                      ),
                      SizedBox(height: responsiveHeight(context, 0.01)),
                    ],
                  );
                }
                return Shimmer.fromColors(
                  baseColor: AppColors.accent,
                  highlightColor: AppColors.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Customize your notification preferences to stay updated with what\'s important. Manage alerts for your account, groups, subscriptions',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff5D6166),
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Account Notifications',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Login Alerts',
                              provider: false,
                              onChanged: (value) {
                                //  = value!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Password Changes',
                              provider: false,
                              onChanged: (value) {
                                //  = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Group Notifications',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'New Group Creation',
                              provider: false,
                              onChanged: (value) {
                                //  = value!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Invitations',
                              provider: false,
                              onChanged: (value) {
                                //  = value!;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CheckboxRow(
                              text: 'Messages',
                              provider: false,
                              onChanged: (value) {
                                //  = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Subscription Notifications',
                              style: GoogleFonts.lato(
                                color: AppColors.textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'Subscription Updates',
                              provider: false,
                              onChanged: (value) {
                                //  = value!;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'Payment Reminders',
                              onChanged: (value) {
                                //  = value!;
                              },
                              provider: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CheckboxRow(
                              text: 'Renewal Alerts',
                              onChanged: (value) {
                                //  = value!;
                              },
                              provider: false,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}
