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
                            'These Terms and Conditions ("Terms") govern your use of our services. By accessing or using ',
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
                            ", you agree to comply with and be bound by these Terms.",
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
                //! Definitions
                Text(
                  "Definitions",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
        
                BulletPointWidget(
                  textWidget: RichText(
                    text: TextSpan(
                      text: '"Service": The  ',
                      style: GoogleFonts.lato(
                        color: AppColors.textColor01,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "SharePact ",
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'mobile app and associated services.',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor01,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text: '"User": Anyone who uses the Service.',
                ),
                const SizedBox(
                  height: 10,
                ),
        
                BulletPointWidget(
                  textWidget: RichText(
                    text: TextSpan(
                      text: '"Group": A collective purchasing group created on  ',
                      style: GoogleFonts.lato(
                        color: AppColors.textColor01,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "SharePact ",
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      '"Subscription": A paid service accessed through a Group.',
                ),
                const SizedBox(
                  height: 20,
                ),
                //! User Responsibilities
                Text(
                  "User Responsibilities",
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
                      'Users must provide accurate information when creating a Group.',
                ),
                const SizedBox(
                  height: 10,
                ),
                BulletPointWidget(
                  textWidget: RichText(
                    text: TextSpan(
                      text:
                          'Users must follow all rules and instructions provided by  ',
                      style: GoogleFonts.lato(
                        color: AppColors.textColor01,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "SharePact ",
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Users are responsible for maintaining the confidentiality of their account information.',
                ),
        
                const SizedBox(
                  height: 20,
                ),
                //! Group Creation and Management
                Text(
                  "Group Creation and Management",
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
                      'Group creators are responsible for managing the Group, including inviting members and ensuring compliance with these Terms.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Groups must comply with all applicable laws and regulations.',
                ),
        
                const SizedBox(
                  height: 20,
                ),
                //! Payment and Fees
                Text(
                  " Payment and Fees",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                BulletPointWidget(
                  textWidget: RichText(
                    text: TextSpan(
                      text: 'All payments must be made through  ',
                      style: GoogleFonts.lato(
                        color: AppColors.textColor01,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: "SharePact's ",
                          style: GoogleFonts.lato(
                            color: AppColors.textColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: 'secure payment system.',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor01,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const BulletPointWidget(
                  text:
                      'Users are responsible for any fees associated with their Subscription.',
                ),
                const SizedBox(
                  height: 10,
                ),
                const BulletPointWidget(
                  text:
                      'Group members share the cost of the Subscription, as outlined during Group creation.',
                ),
        
                const SizedBox(
                  height: 20,
                ),
                //! Cancellation and Termination
                Text(
                  "Cancellation and Termination",
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
                      'Groups can be canceled at any time through the app. Users will be responsible for any fees incurred up to the cancellation date.',
                ),
                const SizedBox(
                  height: 10,
                ),
                BulletPointWidget(
                  textWidget: RichText(
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
                              'reserves the right to terminate or suspend access to any Group or User for violations of these Terms or for any other reason at our discretion.',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor01,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //! Refunds
                Text(
                  "Refunds",
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
                      'Refund policies will vary depending on the Subscription service. Users should refer to the specific service’s terms for details.',
                ),
                const SizedBox(
                  height: 10,
                ),
                BulletPointWidget(
                  textWidget: RichText(
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
                              'is not responsible for refund policies of third-party Subscription services.',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor01,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
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
                BulletPointWidget(
                  textWidget: RichText(
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
                              'is not liable for any indirect, incidental, or consequential damages arising from the use of the Service.',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor01,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                BulletPointWidget(
                  textWidget: RichText(
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
                              'SharePact\'s total liability for any claims under these Terms is limited to the amount paid by the User for the Service.',
                          style: GoogleFonts.lato(
                            color: AppColors.textColor01,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
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
                  'Users’ personal information is protected according to our Privacy Policy, which is incorporated into these Terms by reference.',
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
                  "Changes to Terms",
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
                            'reserves the right to modify these Terms at any time. Users will be notified of any changes, and continued use of the Service constitutes acceptance of the revised Terms.',
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
                  'These Terms are governed by and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law principles.',
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
                  'For any questions or concerns about these Terms, please contact us at [Contact Information].',
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
