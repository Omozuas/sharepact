import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/widgets/bullet_points.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

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
          "Terms & Conditions",
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
                    text: "Welcome to ",
                    style: GoogleFonts.lato(
                      color: AppColors.textColor01,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(
                        text: "SharePact! ",
                        style: GoogleFonts.lato(
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text:
                            'These Terms and Conditions ("Terms") govern your use of the ',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor01,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "SharePact",
                        style: GoogleFonts.lato(
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' mobile application ("App") and its associated services ("Services"). By accessing or using the App, you agree to comply with these Terms. Please read them carefully.',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //! Account Registration
                Text(
                  " Account Registration",
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
                  'To use SharePact, you must register for an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                 const SizedBox(
                  height: 10,
                ),
                 //! Eligibility
                Text(
                  " Eligibility",
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
                  'You must be at least 13 years old to use the App. By registering and using the App, you represent and warrant that you meet this age requirement.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                 const SizedBox(
                  height: 10,
                ),
                //! Trusted Relationships
                Text(
                  "Trusted Relationships",
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
                      'SharePact is intended for use among family, friends, households, and other trusted individuals. By using the App, you agree to engage only with people you know and trust.',
                ),
                const SizedBox(
                  height: 10,
                ),
                  const BulletPointWidget(
                  text:
                      'No Responsibility for Scams: SharePact is not responsible for any losses, scams, or fraudulent activities that may occur as a result of interacting with strangers or individuals outside of your trusted circle.',
                ),
               
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'User Vigilance: You are responsible for ensuring that you interact only with people you trust, as SharePact does not verify the identity or trustworthiness of users.',
                ),
        
                const SizedBox(
                  height: 20,
                ),
                 //! Payment Processing
                Text(
                  " Payment Processing",
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
                  'All payments made through SharePact are processed by third-party payment providers. By using the App, you agree to the terms and conditions of the applicable payment provider. SharePact is not responsible for any issues arising from payment processing, including delays or errors.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                 const SizedBox(
                  height: 20,
                ),
                 //! Fees and Charges
                Text(
                  " Fees and Charges",
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
                  'SharePact may charge fees for certain features or services. All applicable fees will be disclosed to you before you make any payment. By using the App, you agree to pay all fees and charges associated with your use of the Services.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                
                 const SizedBox(
                  height: 20,
                ),
                //! Non-Payment Consequences
                Text(
                  "Non-Payment Consequences",
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
                      'Group Member Non-Payment: If you fail to make a payment before the deadline, you will be automatically removed from the group and will forfeit your participation in that particular group purchase or subscription.',
                ),
                const SizedBox(
                  height: 10,
                ),
                  const BulletPointWidget(
                  text:
                      'Group Creator Non-Payment: If the group creator does not make their payment, they will not be eligible for disbursement of funds from the group.',
                ),
               
                const SizedBox(
                  height: 20,
                ),
 //! Disbursement Rules
                Text(
                  "Disbursement Rules",
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
                      ' Disbursement to the group creator will only be initiated when all group members have confirmed their access to the shared service or product.',
                ),
                const SizedBox(
                  height: 10,
                ),
                  const BulletPointWidget(
                  text:
                      'SharePact reserves the right to withhold disbursement if there are disputes or unresolved issues among group members.',
                ),
               
                const SizedBox(
                  height: 20,
                ),
  //! Termination and Suspension
                Text(
                  "Termination and Suspension",
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
                  'SharePact reserves the right to suspend or terminate your account at any time, with or without notice, for violation of these Terms or for any other reason deemed necessary to protect the integrity of the platform.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //! Limitation of Liability
                Text(
                  "Limitation of Liability",
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
                  'To the fullest extent permitted by law, SharePact and its affiliates will not be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or in connection with your use of the App or Services.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //! Termination and Suspension
                Text(
                  "Indemnification",
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
                  'You agree to indemnify and hold harmless SharePact, its affiliates, and their respective officers, directors, employees, and agents from any claims, liabilities, damages, losses, and expenses arising out of your use of the App, your violation of these Terms, or your infringement of any rights of another person or entity.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //! Privacy
                Text(
                  "Privacy",
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
                  'Your use of SharePact is subject to our Privacy Policy, which outlines how we collect, use, and protect your personal information.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //! Changes to Terms
                Text(
                  "Changes to the Terms",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                            'We may modify these Terms at any time. If we make changes, we will notify you by revising the "Effective Date" at the top of these Terms. Your continued use of the App after the changes become effective constitutes your acceptance of the revised Terms.',
                        style: GoogleFonts.lato(
                          color: AppColors.textColor01,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //! Governing Law
                Text(
                  "Governing Law",
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
                  'These Terms are governed by and construed in accordance with the laws of Nigeria, without regard to its conflict of law principles.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                  'If you have any questions about these Terms, please contact us at support@sharepact.com.',
                  style: GoogleFonts.lato(
                    color: AppColors.textColor01,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                            ' you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions',
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
