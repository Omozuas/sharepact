import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/screens/bank_details/controller/bank_details_controller.dart';
import 'package:sharepact_app/support_screen.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import '../../../responsive_helpers.dart';

class BankDetailsScreen extends ConsumerWidget {
  BankDetailsScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankDetails = ref.watch(bankDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Bank Details",
          style: GoogleFonts.lato(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: responsiveHeight(context, 1),
        padding:
            EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
        child: SingleChildScrollView(

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Manage Your Bank Details to Facilitate Group Payments. Ensure Your Information is Accurate for Seamless Transactions',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff5D6166),
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: bankDetails.showBankDetails,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.skyBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Account Name: ',
                            style: GoogleFonts.lato(
                              color: AppColors.textColor01,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "${bankDetails.nameController.text}",
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Bank Name: ',
                            style: GoogleFonts.lato(
                              color: AppColors.textColor01,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text: "${bankDetails.bankController.text}",
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Account Number: ',
                            style: GoogleFonts.lato(
                              color: AppColors.textColor01,
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    "${bankDetails.accountNumberController.text}",
                                style: GoogleFonts.lato(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: bankDetails.showBankDetails,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppImages.warningIcon),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      'To make any changes to your bank information, please contact ',
                                  style: GoogleFonts.lato(
                                    color: AppColors.textColor01,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: "support",
                                        style: GoogleFonts.lato(
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const SupportScreen(),
                                              ),
                                            );
                                          }),
                                    TextSpan(
                                      text: ' for assistance',
                                      style: GoogleFonts.lato(
                                        color: AppColors.textColor01,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: !bankDetails.showBankDetails,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Account Name',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: responsiveHeight(context, 0.005)),
                      TextFormField(
                        controller: bankDetails.nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter name',
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xff5D6166),
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xffBBC0C3), width: 1),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty == true) {
                            return "Name required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Bank Name',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: responsiveHeight(context, 0.005)),
                      TextFormField(
                           controller: bankDetails.bankController,
                        decoration: InputDecoration(
                          hintText: 'Enter bank name',
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xff5D6166),
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xffBBC0C3), width: 1),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty == true) {
                            return "Bank Name required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Account Number',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: responsiveHeight(context, 0.005)),
                      TextFormField(
                           controller: bankDetails.accountNumberController,
                           keyboardType: TextInputType.number,
                           maxLength: 10,
                        decoration: InputDecoration(
                          hintText: 'Enter account number',
                          hintStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: const Color(0xff5D6166),
                                  ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                                color: Color(0xffBBC0C3), width: 1),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty == true) {
                            return "Account number required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: responsiveHeight(context, 0.04)),
                        SizedBox(
                  height: responsiveHeight(context, 0.08),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(bankDetailsProvider.notifier).showBankDetails =
                            true;
                      }
                    },
                    child: const Text('Save'),
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 0.01)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      '*',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: Text(
                        'Please ensure your bank information is accurate. Once saved, it cannot be edited. You will have to contact support for any changes',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff5D6166),
                            fontSize: 12),
                      ),
                    ),
                  ],
                )
              
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
