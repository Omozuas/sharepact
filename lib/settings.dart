import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/screens/bank_details/screen/bank_details_screen.dart';
import 'package:sharepact_app/change_password.dart';
import 'package:sharepact_app/edit_profile.dart';
import 'package:sharepact_app/notification_settings.dart';
import 'package:sharepact_app/privacy_policy.dart';
import 'package:sharepact_app/support_screen.dart';
import 'package:sharepact_app/terms_and_conditions.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16.0),
        padding: const EdgeInsets.only(bottom: 16.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffD1D4D7),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SettingsTile(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () {
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
                            builder: (context) =>
                                const ChangePasswordScreen()));

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
                            builder: (context) =>  BankDetailsScreen()));

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
                    const Divider(),
                    SettingsTile(
                      icon: Icons.feedback_outlined,
                      title: 'Feedback',
                      onTap: () {
                        // Handle Feedback action
                      },
                    ),
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
                          onPressed: () {},
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
                          onPressed: () {},
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PopupContentWidget extends StatelessWidget {
  final String title, actionBtnText;
  final VoidCallback onPressed;
  final Color buttonColor;
  const PopupContentWidget({
    super.key,
    required this.title,
    required this.actionBtnText,
    required this.onPressed,
    this.buttonColor = AppColors.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppColors.textColor02,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
              ),
              onPressed: onPressed,
              child: Text(actionBtnText),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.lato(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SettingsTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
