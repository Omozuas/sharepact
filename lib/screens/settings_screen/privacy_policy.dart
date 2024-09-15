import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/widgets/bullet_points.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Privacy Policy",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    text: "SharePact ",
                    style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(
                        text:
                            'is committed to protecting your privacy and handling your personal information with care. This Privacy Policy outlines how we collect, use, and protect your information when you use our mobile application and services.',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor01,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //! Information We Collect
                Text(
                  "Information We Collect",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Personal Information: When you sign up for SharePact, we collect your email address and password for account creation and authentication.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Payment Information: We facilitate payments through invoices that include a link to Flutterwave for processing your payments securely.',
                ),
                 const SizedBox(
                  height: 10,
                ),
                 const BulletPointWidget(
                  text:
                      'Bank Details: If you are a group owner or creator, we collect bank details to process disbursements.',
                ),
        
                const SizedBox(
                  height: 20,
                ),
        
                //! How We Use Your Information
                Text(
                  "How We Use Your Information",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'To Provide Services: We use your email to create and manage your account, process payments, and facilitate group interactions.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'To Manage Payments: We use your bank details to disburse funds to group creators as necessary.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'To Communicate: We use your email address to send you account-related updates, invoices, and reminders.',
                ),
        
                const SizedBox(
                  height: 20,
                ),
                //! Sharing Your Information
                Text(
                  "Sharing Your Information",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'With Payment Processors: We may share payment information with Flutterwave to process payments securely.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'For Disbursements: We use bank details to handle disbursements to group creators.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'For Legal Reasons: We may disclose your information if required by law or to protect our rights and safety.',
                ),
        
                const SizedBox(
                  height: 20,
                ),
                //! Data Security
                Text(
                  "Security",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'We implement industry-standard security measures to protect your personal information, including encryption and secure storage practices. However, please note that no online transmission or storage method is completely secure.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //! Your Rights
                Text(
                  "Your Choices",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Access and Update: You can access and update your email address and other personal information through the app settings.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Opt-Out: You can choose not to receive communications by unticking the notifications and also delete your account in the app.',
                ),
                const SizedBox(
                  height: 10,
                ),
                //! Changes to This Privacy Policy
                Text(
                  "Changes to This Privacy Policy",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'We may update this Privacy Policy occasionally. Any changes will be posted on this page with a revised effective date. We encourage you to review this policy periodically',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //! Contact Information
                Text(
                  "Contact Information",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'If you have any questions or concerns about this Privacy Policy or our data practices, please contact us at: Email: support@sharepact.com',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'By using ',
                    style: GoogleFonts.lato(
                      color: AppColors.textColor01,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "SharePact, ",
                        style: GoogleFonts.lato(
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text:
                            'you agree to the collection and use of your information as described in this Privacy Policy.',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor01,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
