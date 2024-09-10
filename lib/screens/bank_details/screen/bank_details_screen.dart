import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/api/model/bank/bank_model.dart';
import 'package:sharepact_app/api/riverPod/get_all_banks.dart';
import 'package:sharepact_app/api/riverPod/get_bank_details.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/bank_details/controller/bank_details_controller.dart';
import 'package:sharepact_app/screens/home/components/input_field.dart';
import 'package:sharepact_app/screens/settings_screen/support_screen.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../../../responsive_helpers.dart';

class BankDetailsScreen extends ConsumerStatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BankDetailsScreenState();
}

class _BankDetailsScreenState extends ConsumerState<BankDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController bankController = TextEditingController();

  final TextEditingController accountNumberController = TextEditingController();
  String selectedBank = '';
  String bankCode = '';
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {getBankDetails(), getAllBanks()});
  }

  Future<void> getBankDetails() async {
    await ref.read(getBankProvider.notifier).getBankById();
    final res = ref.watch(getBankProvider);

    if (mounted) {
      if (res.value != null) {
        final item = res.value;
        if (item?.code == 200) {
          ref.read(bankDetailsProvider.notifier).showBankDetails = true;
        } else {
          ref.watch(bankDetailsProvider);
          ref.read(bankDetailsProvider.notifier).showBankDetails = false;
          // showErrorPopup(message: message, context: context);
          return;
        }
      }
    }
  }

  Future<void> postBankDetails() async {
    try {
      await ref.read(profileProvider.notifier).postBankDetails(
          accountName: nameController.text,
          bankName: selectedBank,
          sortCode: bankCode,
          accountNumber: accountNumberController.text);
      final res = ref.read(profileProvider).postBankDetails;
      final result = res.value;
      if (mounted) {
        if (result != null) {
          if (result.code == 201) {
            showSuccess(message: result.message!, context: context);
            ref.read(bankDetailsProvider.notifier).showBankDetails = true;
            await getBankDetails();
            return;
          } else {
            showErrorPopup(context: context, message: result.message!);
            ref.watch(bankDetailsProvider);
            ref.read(bankDetailsProvider.notifier).showBankDetails = false;
          }
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context: context, message: e.toString());
      }
    }
  }

  Future<void> getAllBanks() async {
    await ref.read(getAllBankProvider.notifier).getAllBank();
    final res = ref.watch(getAllBankProvider);
    if (mounted) {
      if (res.value != null) {
        final message = res.value?.message;
        final item = res.value;
        if (item?.code == 200) {
        } else {
          showErrorPopup(message: message, context: context);
          return;
        }
      }
    }
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final width = MediaQuery.of(context).size.width;
    final getbankDetails = ref.watch(getBankProvider);
    final bankDetails = ref.watch(bankDetailsProvider);
    final getAllbank = ref.watch(getAllBankProvider);
    final isLoading = ref.watch(profileProvider).postBankDetails.isLoading;
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
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),
                getbankDetails.when(
                    skipLoadingOnReload: true,
                    data: (getbankDetails) {
                      final item = getbankDetails?.data;
                      return Visibility(
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
                                      text: item?.accountName ?? '',
                                      style: GoogleFonts.lato(
                                        color: AppColors.textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
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
                                      text: item?.bankName ?? '',
                                      style: GoogleFonts.lato(
                                        color: AppColors.textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
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
                                      text: item?.accountNumber ?? '',
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
                      );
                    },
                    error: (error, stackTrace) {
                      final err = error as BankResponseModel;
                      return Text('${err.message}');
                    },
                    loading: () => Shimmer.fromColors(
                          baseColor: AppColors.accent,
                          highlightColor: AppColors.primaryColor,
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
                                      text: "loading....",
                                      style: GoogleFonts.lato(
                                        color: AppColors.textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
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
                                      text: "loading....",
                                      style: GoogleFonts.lato(
                                        color: AppColors.textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
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
                                      text: "loading....",
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
                        )),
                const SizedBox(
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
                            const SizedBox(
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
                const SizedBox(
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
                        controller: nameController,
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
                      const SizedBox(
                        height: 10,
                      ),
                      AppInputField(
                        headerText: 'Bank Name',
                        style: GoogleFonts.lato(
                          color: const Color(0xff343A40),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        hintText: 'Select Bank Name',
                        trailing: DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSearchBox: true, // Enable search functionality
                            searchFieldProps: TextFieldProps(
                              decoration: InputDecoration(
                                hintText: "Search Bank Name",
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: width * .05,
                                ),
                              ),
                            ),
                          ),
                          items: getAllbank.value?.data
                                  ?.map((bank) => bank.name ?? '')
                                  .toList() ??
                              [],
                          selectedItem:
                              selectedBank.isEmpty ? null : selectedBank,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.only(
                                left: width * .05,
                                right: width * .05,
                              ),
                              hintText: 'Select Bank Name',
                            ),
                          ),
                          onChanged: (String? value) {
                            if (value != null) {
                              setState(() {
                                selectedBank = value;
                                final bankCode1 = getAllbank.value?.data
                                    ?.firstWhere((plan) => plan.name == value);
                                bankCode = bankCode1?.code ?? "0";
                              });
                            }
                          },
                        ),
                      ),
                      Text(
                        'Account Number',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: responsiveHeight(context, 0.005)),
                      TextFormField(
                        controller: accountNumberController,
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
                          onPressed: isLoading
                              ? () {}
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    postBankDetails();
                                  }
                                },
                          child: isLoading
                              ? const Text('Saving....')
                              : const Text('Save'),
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
                          const SizedBox(
                            width: 3,
                          ),
                          Expanded(
                            child: Text(
                              'Please ensure your bank information is accurate. Once saved, it cannot be edited. You will have to contact support for any changes',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
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
