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
                            'values your privacy and is committed to protecting your personal information. This Privacy Policy explains how we collect, use, and safeguard your data when you use our mobile app and services ("Service").',
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
                      'Personal Information: When you create an account or join a group, we may collect information such as your name, email address, and payment details.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Usage Data: We collect information about how you use our Service, including the pages you visit, the actions you take, and the devices you use to access the Service.',
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
                      'To Provide and Improve Our Service: We use your information to create and manage your account, process transactions, and enhance the user experience.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'To Communicate with You: We may use your contact information to send you updates, respond to inquiries, and provide customer support.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'To Ensure Security: We use your data to detect and prevent fraud, unauthorized access, and other security issues.',
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
                      'With Group Members: Your name and basic information may be shared with other members of your subscription group',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'With Third-Party Services: We may share your data with third-party service providers to facilitate payments, manage subscriptions, and perform other functions on our behalf.',
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
                  "Data Security",
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
                  'We implement industry-standard security measures to protect your personal information from unauthorized access, alteration, and disclosure.',
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
                  "Your Rights",
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
                      'Access and Correction: You have the right to access and update your personal information at any time.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Deletion: You can request the deletion of your account and personal data by contacting us at [Contact Information].',
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
                  'We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the new policy on our app and updating the effective date.',
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
                  'If you have any questions or concerns about this Privacy Policy, please contact us at [Contact Information].',
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
