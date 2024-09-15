import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'package:sharepact_app/screens/home/components/input_field.dart';
import 'package:intl/intl.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';
import 'package:url_launcher/url_launcher.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key, this.id});
  final String? id;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      CreateGroupScreenState();
}

class CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController subScriptionCostController =
      TextEditingController();
  String selectedCategory = '';
  String selectedService = '';
  String selectedPlan = '';
  String groupName = '';
  String numberOfMembers = '';
  String existingGroup = 'Select Yes or No';
  String oneTimePaymentSt = 'Select Yes or No';
  int selectedPrice = 0;
  bool agreedToTerms = false;
  bool showDatePickerFlag = false;
  bool oneTimePayment = false;
  DateTime? selectedDate;

  final dateformat = DateFormat('dd MMMM, yyyy');

  Future<void> _selectDate(BuildContext context) async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: selectedDate ?? DateTime.now(),
    //   firstDate: DateTime(2000),
    //   lastDate: DateTime(2101),
    // );
    // if (picked != null && picked != selectedDate) {
    //   setState(() {
    //     selectedDate = picked;
    //     showDatePickerFlag = true;
    //   });
    // }
    DateTime? dateTime = await showOmniDateTimePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      lastDate: DateTime.now()
          .add(const Duration(days: 30)), // Restrict to next 30 days
      type: OmniDateTimePickerType.date,
      firstDate: DateTime.now(),
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      theme: Theme.of(context).copyWith(
        // ignore: deprecated_member_use
        useMaterial3: false,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primaryColor,
          onPrimary: Colors.white,
          onSurface: Colors.black, // body text color
        ),
        dialogBackgroundColor: Colors.white,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor, // button text color
          ),
        ),
      ),
    );
    setState(() {
      selectedDate = dateTime;
      showDatePickerFlag = true;
    });
  }

  final _url = Uri.parse('https://sharepact.com/terms');
  Future<void> _launchUrl() async {
    if (!await launchUrl(
      _url,
      mode: LaunchMode.inAppWebView,
      // browserConfiguration: const BrowserConfiguration(showTitle: true),
    )) {
      throw Exception('Could not launch $_url');
    }
  }
  // void _showPrivacyDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Do you have an Existing Group?'),
  //         content: Text('Do you have an Existing Group?'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('No'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Yes'),
  //             onPressed: () {
  //               _selectDate(context);
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<void> _proceedWithGroupCreation() async {
    // Handle the creation of group without showing date picker
    // For example, navigate to the next screen or show a confirmation message
    await ref.read(profileProvider.notifier).validateToken();
    final isTokenValid = ref.read(profileProvider).isTokenValid.value;
    if (isTokenValid == false) {
      _handleSessionExpired();
      return;
    }
    if (mounted) {
      if (groupNameController.text.isEmpty) {
        showErrorPopup(context: context, message: 'Enter a Group Name');
        return;
      }
      if (subScriptionCostController.text.isEmpty) {
        showErrorPopup(context: context, message: 'Enter a Subscription Cost');
        return;
      }
      if (numberOfMembers.isEmpty) {
        showErrorPopup(context: context, message: 'Enter number of members');
        return;
      }
    }
    int numberOfMembersString = int.parse(numberOfMembers);
    int subscriptionCost =
        int.parse(subScriptionCostController.text.replaceAll(',', ''));
    bool isExistingGroup = existingGroup.toLowerCase() == 'yes' ? true : false;
    bool isOneTimePayment =
        oneTimePaymentSt.toLowerCase() == 'yes' ? true : false;

    try {
      await ref.read(profileProvider.notifier).createGroup(
            serviceId: widget.id!,
            groupName: groupNameController.text,
            subscriptionCost: subscriptionCost,
            numberOfMembers: numberOfMembersString,
            oneTimePayment: isOneTimePayment,
            existingGroup: isExistingGroup,
            nextSubscriptionDate: isExistingGroup
                ? selectedDate
                : null, // Pass selectedDate if applicable
          );
      final res = ref.read(profileProvider).createGroup.value;
      if (res?.code == 201) {
        if (mounted) {
          showSuccess(message: res!.message!, context: context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ControllerNavScreen(
                      initialIndex: 2,
                    )),
          );
        }
      } else {
        if (mounted) {
          showErrorPopup(context: context, message: res?.message);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context: context, message: e.toString());
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getserviceById());
  }

  Future<void> getserviceById() async {
    try {
      await ref.read(profileProvider.notifier).validateToken();
      final isTokenValid = ref.read(profileProvider).isTokenValid.value;
      if (isTokenValid == false) {
        _handleSessionExpired();
        return;
      }
      await _fetchbyId();
    } catch (e) {
      if (mounted) {
        showErrorPopup(context: context, message: e.toString());
      }
    }
  }

  Future<void> _fetchbyId() async {
    try {
      await ref.read(profileProvider.notifier).getServiceById(id: widget.id!);
      final categories = ref.watch(profileProvider).getServiceById;
      if (categories.value?.code != 200) {
        if (mounted) {
          showErrorPopup(context: context, message: categories.value?.message);
          await getserviceById();
          return;
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorPopup(context: context, message: e.toString());
      }
    }
  }

  void _handleSessionExpired() {
    if (mounted) {
      showErrorPopup(context: context, message: 'Session Expired');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final services = ref.watch(profileProvider).getServiceById;
    final isLoading = ref.watch(profileProvider).postBankDetails.isLoading;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xffBBC0C3))),
            child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close, color: Color(0xffBBC0C3))),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: height * .01),
              Text(
                services.hasValue
                    ? 'Create a New  ${services.value?.data?.serviceName} Subscription Group'
                    : 'loadind....',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * .01),
              Text(
                'Invite friends and family to share the cost of your favorite subscriptions. Save more by creating a group and unlocking bulk discounts together',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: height * 0.02),
              Stack(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: height * .12, minWidth: width),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please note :',
                            style: GoogleFonts.lato(
                              color: const Color(0xff343A40),
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: height * .01),
                          Text.rich(
                            TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'For ',
                                  style: GoogleFonts.lato(
                                    color: const Color(0xff343A40),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'spotify',
                                  style: GoogleFonts.lato(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle tap
                                    },
                                ),
                                TextSpan(
                                  text: ' or ',
                                  style: GoogleFonts.lato(
                                    color: const Color(0xff343A40),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Apple music',
                                  style: GoogleFonts.lato(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle tap
                                    },
                                ),
                                TextSpan(
                                  style: GoogleFonts.lato(
                                    color: const Color(0xff343A40),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  text:
                                      ' subscriptions, an agent will be managing the group and is counted as a member',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: width * .00000001,
                    child: Container(
                      width: width * .03,
                      height: height * .12,
                      decoration: const BoxDecoration(
                        color: Color(0xFF007BFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          bottomLeft: Radius.circular(16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .03),
              // AppInputField(
              //   headerText: 'Subscription Category',
              //   style: GoogleFonts.lato(
              //     color: const Color(0xff343A40),
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              //   hintText: 'Select category',
              //   trailing: DropdownButton<String>(
              //     icon: const Icon(HeroiconsOutline.chevronDown),
              //     padding:
              //         EdgeInsets.only(left: width * .04, right: width * .04),
              //     items: <String>[
              //       'Category 1',
              //       'Category 2',
              //       'Category 3',
              //     ].map((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(
              //           value,
              //           style: GoogleFonts.lato(
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //     hint: Text(
              //       selectedCategory.isEmpty
              //           ? 'Select category'
              //           : selectedCategory,
              //       style: GoogleFonts.lato(),
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //     underline: const SizedBox(),
              //     isExpanded: true,
              //     onChanged: (value) {
              //       if (value != null) {
              //         setState(() {
              //           selectedCategory = value;
              //         });
              //       }
              //     },
              //   ),
              // ),
              // AppInputField(
              //   headerText: 'Subscription Service',
              //   style: GoogleFonts.lato(
              //     color: const Color(0xff343A40),
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              //   hintText: 'Select service',
              //   trailing: DropdownButton<String>(
              //     icon: const Icon(HeroiconsOutline.chevronDown),
              //     padding:
              //         EdgeInsets.only(left: width * .04, right: width * .04),
              //     items: <String>[
              //       'Service 1',
              //       'Service 2',
              //       'Service 3',
              //     ].map((String value) {
              //       return DropdownMenuItem<String>(
              //         value: value,
              //         child: Text(
              //           value,
              //           style: GoogleFonts.lato(
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //     hint: Text(
              //       selectedService.isEmpty
              //           ? 'Select service'
              //           : selectedService,
              //       style: GoogleFonts.lato(),
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //     underline: const SizedBox(),
              //     isExpanded: true,
              //     onChanged: (value) {
              //       if (value != null) {
              //         setState(() {
              //           selectedService = value;
              //         });
              //       }
              //     },
              //   ),
              // ),

              // AppInputField(
              //   headerText: 'Subscription Plan',
              //   style: GoogleFonts.lato(
              //     color: const Color(0xff343A40),
              //     fontSize: 16,
              //     fontWeight: FontWeight.w600,
              //   ),
              //   hintText: 'Select plan',
              //   trailing: DropdownButton<String>(
              //     icon: const Icon(HeroiconsOutline.chevronDown),
              //     padding:
              //         EdgeInsets.only(left: width * .04, right: width * .04),
              //     items:
              //         services.value?.data?.subscriptionPlans?.map((toElement) {
              //       return DropdownMenuItem<String>(
              //         value: toElement.planName,
              //         child: Text(
              //           toElement.planName ?? '',
              //           style: GoogleFonts.lato(
              //             fontWeight: FontWeight.w400,
              //           ),
              //         ),
              //       );
              //     }).toList(),
              //     hint: Text(
              //       selectedPlan.isEmpty ? 'Select plan' : selectedPlan,
              //       style: GoogleFonts.lato(),
              //     ),
              //     borderRadius: BorderRadius.circular(10),
              //     underline: const SizedBox(),
              //     isExpanded: true,
              //     onChanged: (value) {
              //       if (value != null) {
              //         setState(() {
              //           selectedPlan = value;
              //           selectedPrice = services.value?.data?.subscriptionPlans!
              //                   .firstWhere((plan) => plan.planName == value)
              //                   .price ??
              //               0;
              //         });
              //       }
              //     },
              //   ),
              // ),

              AppInputField(
                controller: groupNameController,
                headerText: 'Group Name',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'e.g Spotify family',
              ),
              AppInputField(
                controller: subScriptionCostController,
                headerText: 'Subscription Cost',
                keyboardType: TextInputType.number,
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  ThousandsSeparatorInputFormatter(), // Add the custom formatter
                ],
                hintText: 'Subscription Cost',
              ),
              AppInputField(
                headerText: 'Number of Members',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'Select member',
                trailing: DropdownButton<String>(
                  icon: const Icon(HeroiconsOutline.chevronDown),
                  padding:
                      EdgeInsets.only(left: width * .04, right: width * .04),
                  items: <String>['2', '3', '4', '5', '6'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    numberOfMembers.isEmpty ? 'Choose number' : numberOfMembers,
                    style: GoogleFonts.lato(),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        numberOfMembers = value;
                      });
                    }
                  },
                ),
              ),

              AppInputField(
                headerText: 'One Time Payment?',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'Select Yes or No',
                trailing: DropdownButton<String>(
                  icon: const Icon(HeroiconsOutline.chevronDown),
                  padding:
                      EdgeInsets.only(left: width * .04, right: width * .04),
                  items: <String>['Yes', 'No'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    oneTimePaymentSt,
                    style: GoogleFonts.lato(),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        oneTimePaymentSt = value;

                        if (oneTimePaymentSt == 'Yes') {
                          setState(() {
                            oneTimePayment = false;
                          });
                        } else if (oneTimePaymentSt == 'No') {
                          setState(() {
                            oneTimePayment = true;
                          });
                        }
                      });
                    }
                  },
                ),
              ),
              if (oneTimePayment)
                AppInputField(
                  headerText: 'Do you have an Existing Group?',
                  style: GoogleFonts.lato(
                    color: const Color(0xff343A40),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  hintText: 'Select Yes or No',
                  trailing: DropdownButton<String>(
                    icon: const Icon(HeroiconsOutline.chevronDown),
                    padding:
                        EdgeInsets.only(left: width * .04, right: width * .04),
                    items: <String>['Yes', 'No'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      existingGroup,
                      style: GoogleFonts.lato(),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    underline: const SizedBox(),
                    isExpanded: true,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          existingGroup = value;

                          if (existingGroup == 'Yes') {
                            setState(() {
                              showDatePickerFlag = true;
                            });
                          } else {
                            setState(() {
                              showDatePickerFlag = false;
                              selectedDate = null;
                            });

                            // _proceedWithGroupCreation();
                          }
                        });
                      }
                    },
                  ),
                ),

              if (showDatePickerFlag)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * .02),
                    Text(
                      'Select Date of Next Subscription',
                      style: GoogleFonts.lato(
                        color: const Color(0xff343A40),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * .01),
                    ListTile(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: AppColors.borderColor, width: 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Text(
                          selectedDate == null
                              ? ""
                              : dateformat.format(selectedDate!),
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            // color: selectedDate == null
                            //     ? AppColors.hintTextColor
                            //     : AppColors.black,
                          ),
                        ),
                        trailing: SvgPicture.asset(AppImages.calenderIcon),
                        onTap: () async {
                          await _selectDate(context);
                        }),
                  ],
                ),
              SizedBox(height: height * .01),
              Container(
                width: width,
                padding: const EdgeInsets.all(12),
                color: const Color(0xFF007BFF),
                child: Text(
                  'Payment Details',
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPaymentDetailRow('Subscription Cost',
                        '${subScriptionCostController.text} NGN/', 'Month'),
                    const Divider(),
                    buildPaymentDetailRow('Handling Fee',
                        '${services.value?.data?.handlingFees ?? 0} NGN', ''),
                  ],
                ),
              ),
              const Divider(),
              SizedBox(height: height * .02),
              Text(
                'By creating a new subscription group, you agree to the following terms and conditions:',
                style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff5D6166)),
              ),
              SizedBox(height: height * .01),
              Text.rich(
                TextSpan(
                    text: '• Rules and Instructions: ',
                    style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff5D6166)),
                    children: [
                      TextSpan(
                        text:
                            'Users must adhere to all guidelines and instructions provided by Sharepact.\n\n',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff5D6166)),
                      ),
                      TextSpan(
                        text: '• Cancellation Policy:',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff5D6166)),
                      ),
                      TextSpan(
                        text:
                            ' Subscription groups can be canceled at any time, but users will be responsible for any outstanding fees or charges incurred up to the cancellation date... ',
                        style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff5D6166)),
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _launchUrl();
                            });
                          },
                        text: ' Read Full Terms and Conditions',
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF007BFF),
                        ),
                      ),
                    ]),
              ),
              SizedBox(height: height * .02),
              const Divider(),
              SizedBox(height: height * .02),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        agreedToTerms = !agreedToTerms;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: agreedToTerms
                              ? const Color(0xFF007BFF)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: agreedToTerms
                                ? const Color(0xFF007BFF)
                                : const Color(0xffC0C0C0),
                          )),
                      child: Icon(
                        Icons.check,
                        size: 14,
                        color:
                            agreedToTerms ? Colors.white : Colors.transparent,
                      ),
                    ),
                  ),
                  SizedBox(width: width * .02),
                  Text(
                    'I agree to the Terms and Conditions',
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff5D6166),
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .03),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: agreedToTerms
                      ? isLoading
                          ? () {}
                          : _proceedWithGroupCreation
                      : null,
                  style: ButtonStyle(
                    // ignore: deprecated_member_use
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return const Color(0xFFB0D6FF);
                        }
                        return const Color(
                            0xFF007BFF); // Use the component's default.
                      },
                    ),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0)),
                  ),
                  child: Text(
                    isLoading ? 'Creating...' : 'Create Group',
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: agreedToTerms
                          ? Colors.white
                          : const Color(0xffA2A4A7),
                    ),
                  ),
                ),
              ),
              SizedBox(height: height * .03),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentDetailRow(String? label, price, duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label ?? '',
            style: GoogleFonts.lato(
                color: const Color(0xff343A40),
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          Text.rich(
            TextSpan(
                text: price ?? '',
                style: GoogleFonts.lato(
                    color: const Color(0xff343A40),
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
                children: [
                  TextSpan(
                    text: duration ?? '',
                    style: GoogleFonts.lato(
                        color: const Color(0xff343A40),
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat("#,###");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Only format the new value if it is a number
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Remove any non-digit characters (except commas)
    String newText = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Format the text using NumberFormat
    final formattedText = _formatter.format(int.parse(newText));

    // Maintain the cursor position
    int newOffset =
        formattedText.length - (newValue.text.length - newValue.selection.end);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
