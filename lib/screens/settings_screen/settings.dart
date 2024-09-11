import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepact_app/api/riverPod/categoryProvider.dart';
import 'package:sharepact_app/api/riverPod/get_notifications.dart';
import 'package:sharepact_app/api/riverPod/group_list.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/riverPod/settingsN/otification.dart';
import 'package:sharepact_app/api/riverPod/subscription_provider.dart';
import 'package:sharepact_app/api/riverPod/user_provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/screens/bank_details/screen/bank_details_screen.dart';
import 'package:sharepact_app/screens/settings_screen/change_password.dart';
import 'package:sharepact_app/screens/settings_screen/edit_profile.dart';
import 'package:sharepact_app/screens/settings_screen/notification_settings.dart';
import 'package:sharepact_app/screens/settings_screen/privacy_policy.dart';
import 'package:sharepact_app/screens/settings_screen/support_screen.dart';
import 'package:sharepact_app/screens/settings_screen/terms_and_conditions.dart';
import 'package:sharepact_app/widgets/widgets.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => SettingsScreenState();
}

class SettingsScreenState extends ConsumerState<SettingsScreen> {
  Future<void> logOut() async {
    try {
      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      await ref
          .read(profileProvider.notifier)
          .checkTokenStatus(token: myToken!);
      final isTokenValid = ref.read(profileProvider).checkTokenstatus;

      if (isTokenValid.value!.code != 200) {
        _handleSessionExpired();
        return;
      }

      await ref.read(profileProvider.notifier).logOut(token: myToken);
      final pUpdater = ref.read(profileProvider).logout;

      // Safely check for value and data
      if (pUpdater.value != null) {
        final message = pUpdater.value?.message;

        // Safely check for code
        if (pUpdater.value?.code == 200) {
          await _clearSessionData();
          ref.invalidate(userProvider);
          if (mounted) {
            showSuccess(message: message!, context: context);
          }
          // Navigate to LoginScreen if logout is successful
          _navigateToLoginScreen();
        } else {
          if (mounted) {
            showErrorPopup(
                message: message ?? 'An error occurred', context: context);
          }
        }
      } else {
        _showLogoutError();
      }
    } catch (e) {
      // Show error if login fails
      _handleError(e);
    }
  }

  Future<void> deletAccount() async {
    try {
      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      await ref
          .read(profileProvider.notifier)
          .checkTokenStatus(token: myToken!);
      final isTokenValid = ref.read(profileProvider).checkTokenstatus;

      if (isTokenValid.value!.code != 200) {
        _handleSessionExpired();
        return;
      }

      await ref.read(profileProvider.notifier).deleteAccount();
      final pUpdater = ref.read(profileProvider).deleteAccount;

      // Safely check for value and data
      if (pUpdater.value != null) {
        final message = pUpdater.value?.message;

        // Safely check for code
        if (pUpdater.value?.code == 200) {
          await _clearSessionData();
          ref.invalidate(userProvider);
          if (mounted) {
            showSuccess(message: message!, context: context);

            // Navigate to LoginScreen if logout is successful
            _navigateToLoginScreen();
          }
        } else {
          if (mounted) {
            showErrorPopup(
                message: message ?? 'An error occurred', context: context);
          }
        }
      } else {
        _showLogoutError();
      }
    } catch (e) {
      // Show error if login fails
      _handleError(e);
    }
  }

  void _showLogoutError() {
    if (mounted) {
      showErrorPopup(
          message: 'Logout failed. Please try again.', context: context);
    }
  }

  void _handleError(e) {
    if (mounted) {
      showErrorPopup(
        message: e.toString().replaceAll('Exception: ', ''),
        context: context,
      );
    }
  }

  Future<void> _clearSessionData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
  }

  void _handleSessionExpired() {
    if (mounted) {
      showErrorPopup(message: 'Session expired', context: context);
      _navigateToLoginScreen();
    }
  }

  void _navigateToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userProvider);
    ref.watch(categoryProvider);
    ref.watch(subscriptionProvider);
    ref.watch(notificationConfigProvider);
    ref.watch(groupListprovider);
    ref.watch(notificationsprovider);
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      padding: const EdgeInsets.only(bottom: 16.0, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffD1D4D7),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  onTap: () async {
                    // Handle Edit Profile action
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const EditProfile()));
                  },
                ),
                const Divider(),
                SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Manage Passwords',
                  onTap: () {
                    // Handle Manage Passwords action
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()));

                    //
                  },
                ),
                const Divider(),
                SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Manage Bank Details',
                  onTap: () {
                    // Handle Manage Bank details
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BankDetailsScreen()));

                    //
                  },
                  // ChangePasswordScreen()
                ),
                const Divider(),
                SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications & Reminders',
                  onTap: () {
                    // Handle Notifications & Reminders action
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const NotificationSettings(),
                      ),
                    );
                  },
                ),
                // const Divider(),
                // SettingsTile(
                //   icon: Icons.feedback_outlined,
                //   title: 'Feedback',
                //   onTap: () {
                //     // Handle Feedback action
                //   },
                // ),
                const Divider(),
                SettingsTile(
                  icon: Icons.support_agent_outlined,
                  title: 'Support',
                  onTap: () {
                    // Handle Support action
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SupportScreen(),
                      ),
                    );
                  },
                ),
                const Divider(),
                SettingsTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    // Handle Privacy Policy action
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicy(),
                      ),
                    );
                  },
                ),
                const Divider(),
                SettingsTile(
                  icon: Icons.article_outlined,
                  title: 'Terms & Conditions',
                  onTap: () {
                    // Handle Terms & Conditions action
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TermsAndConditions(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('LogOut'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      content: PopupContentWidget(
                        title: "Are you sure you want to log out?",
                        actionBtnText: "Proceed",
                        onPressed: logOut,
                      ),
                    );
                  });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Delete Account',
                style: TextStyle(color: Colors.red)),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      content: PopupContentWidget(
                        title:
                            "Are you sure you want to delete your account? This action is irreversible and all your data will be permanently lost",
                        actionBtnText: "Yes, Delete",
                        buttonColor: Colors.red,
                        onPressed: deletAccount,
                      ),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
