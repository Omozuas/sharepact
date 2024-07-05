import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons_flutter/heroicons_flutter.dart';
import 'package:sharepact_app/screens/home/components/input_field.dart';
import 'package:intl/intl.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String selectedCategory = '';
  String selectedService = '';
  String selectedPlan = '';
  String groupName = '';
  String numberOfMembers = '';
  String existingGroup = 'No';
  bool agreedToTerms = false;
  bool showDatePickerFlag = false;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        showDatePickerFlag = true;
      });
    }
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you have an Existing Group?'),
          content: Text('Do you have an Existing Group?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
                _proceedWithGroupCreation();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                _selectDate(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _proceedWithGroupCreation() {
    // Handle the creation of group without showing date picker
    // For example, navigate to the next screen or show a confirmation message
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                'Create a New Subscription Group',
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
                        maxHeight: height * .11, minWidth: width),
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
                      height: height * .11,
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
              AppInputField(
                headerText: 'Subscription Category',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'Select category',
                trailing: DropdownButton<String>(
                  icon: const Icon(HeroiconsOutline.chevronDown),
                  padding:
                      EdgeInsets.only(left: width * .04, right: width * .04),
                  items: <String>[
                    'Category 1',
                    'Category 2',
                    'Category 3',
                  ].map((String value) {
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
                    selectedCategory.isEmpty
                        ? 'Select category'
                        : selectedCategory,
                    style: GoogleFonts.lato(),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                ),
              ),
              AppInputField(
                headerText: 'Subscription Service',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'Select service',
                trailing: DropdownButton<String>(
                  icon: const Icon(HeroiconsOutline.chevronDown),
                  padding:
                      EdgeInsets.only(left: width * .04, right: width * .04),
                  items: <String>[
                    'Service 1',
                    'Service 2',
                    'Service 3',
                  ].map((String value) {
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
                    selectedService.isEmpty
                        ? 'Select service'
                        : selectedService,
                    style: GoogleFonts.lato(),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedService = value;
                      });
                    }
                  },
                ),
              ),
              AppInputField(
                headerText: 'Subscription Plan',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'Select plan',
                trailing: DropdownButton<String>(
                  icon: const Icon(HeroiconsOutline.chevronDown),
                  padding:
                      EdgeInsets.only(left: width * .04, right: width * .04),
                  items: <String>[
                    'Plan 1',
                    'Plan 2',
                    'Plan 3',
                  ].map((String value) {
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
                    selectedPlan.isEmpty ? 'Select plan' : selectedPlan,
                    style: GoogleFonts.lato(),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  isExpanded: true,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedPlan = value;
                      });
                    }
                  },
                ),
              ),
              AppInputField(
                headerText: 'Group Name',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'e.g Spotify family',
              ),
              AppInputField(
                headerText: 'Number of Members',
                style: GoogleFonts.lato(
                  color: const Color(0xff343A40),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                hintText: 'Select plan',
                trailing: DropdownButton<String>(
                  icon: const Icon(HeroiconsOutline.chevronDown),
                  padding:
                      EdgeInsets.only(left: width * .04, right: width * .04),
                  items: <String>['1', '2', '3', '4'].map((String value) {
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
                          _selectDate(context);
                        } else {
                          showDatePickerFlag = false;
                          selectedDate = null;
                          _proceedWithGroupCreation();
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
                      'Next Subscription Date',
                      style: GoogleFonts.lato(
                        color: const Color(0xff343A40),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height * .01),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          DateFormat.yMd().format(selectedDate!),
                          style: GoogleFonts.lato(
                            color: const Color(0xff343A40),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
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
                    buildPaymentDetailRow(
                        'Subscription Cost', '5,000 NGN/', 'Month'),
                    const Divider(),
                    buildPaymentDetailRow('Handling Fee', '500 NGN', ''),
                    const Divider(),
                    buildPaymentDetailRow('Individual Share', '1,100 NGN', ''),
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
                        recognizer: TapGestureRecognizer()..onTap = () {},
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
                      ? () {
                          _showPrivacyDialog();
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return const Color(0xFFB0D6FF);
                        }
                        return const Color(
                            0xFF007BFF); // Use the component's default.
                      },
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 16.0)),
                  ),
                  child: Text(
                    'Create Group',
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
