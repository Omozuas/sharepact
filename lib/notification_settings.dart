import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/providers/settings_provider.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/widgets/checkbox_row.dart';
import 'responsive_helpers.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({super.key});

  @override
  NotificationSettingsState createState() => NotificationSettingsState();
}

class NotificationSettingsState extends State<NotificationSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios),
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
                    provider: loginAlertCheck,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CheckboxRow(
                    text: 'Password Changes',
                    provider: passwordChangeCheck,
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
                    provider: newGroupCreationCheck,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CheckboxRow(
                    text: 'Invitations',
                    provider: invitationsCheck,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CheckboxRow(
                    text: 'Messages',
                    provider: messagesCheck,
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
                    provider: subscriptionUpdatesCheck,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CheckboxRow(
                    text: 'Payment Reminders',
                    provider: paymentRemindersCheck,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CheckboxRow(
                    text: 'Renewal Alerts',
                    provider: paymentRemindersCheck,
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
    );
  }
}
