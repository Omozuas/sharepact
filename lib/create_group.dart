import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  String? selectedCategory;
  String? selectedService;
  String? selectedPlan;
  String? groupName;
  int? numberOfMembers = 5;
  bool isPublic = true;
  bool agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, // Hide the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 24,
                      padding: const EdgeInsets.all(0),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Create a New Subscription Group',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Invite friends and family to share the cost of your favorite subscriptions. Save more by creating a group and unlocking bulk discounts together',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 49,
                      decoration: const BoxDecoration(
                        color: Color(0xFF007BFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Please note :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                const TextSpan(text: 'For '),
                                TextSpan(
                                  text: 'spotify',
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle tap
                                    },
                                ),
                                const TextSpan(text: ' or '),
                                TextSpan(
                                  text: 'Apple music',
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle tap
                                    },
                                ),
                                const TextSpan(
                                  text:
                                      ' subscriptions, an agent will be managing the group and is counted as a member',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Subscription Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                value: selectedCategory,
                items: ['Category 1', 'Category 2', 'Category 3']
                    .map((category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Subscription Service',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                value: selectedService,
                items: ['Service 1', 'Service 2', 'Service 3']
                    .map((service) => DropdownMenuItem<String>(
                          value: service,
                          child: Text(service),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedService = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Subscription Plan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                value: selectedPlan,
                items: ['Plan 1', 'Plan 2', 'Plan 3']
                    .map((plan) => DropdownMenuItem<String>(
                          value: plan,
                          child: Text(plan),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPlan = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Group Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    groupName = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Number of Members',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                value: numberOfMembers,
                items: [1, 2, 3, 4, 5]
                    .map((number) => DropdownMenuItem<int>(
                          value: number,
                          child: Text(number.toString()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    numberOfMembers = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                color: const Color(0xFF007BFF),
                child: const Text(
                  'Payment Details',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPaymentDetailRow('Subscription Cost', '5,000 NGN/Year'),
                    buildPaymentDetailRow('Handling Fee', '500 NGN'),
                    buildPaymentDetailRow('Individual Share', '1,100 NGN'),
                  ],
                ),
              ),
              const Divider(),
              const Text(
                'Group Privacy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: SwitchListTile(
                  title: const Text('Public'),
                  value: isPublic,
                  onChanged: (value) {
                    setState(() {
                      isPublic = value;
                    });
                  },
                  activeColor: const Color(0xFF007BFF),
                  contentPadding: const EdgeInsets.all(0),
                ),
              ),
              const Divider(),
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    const TextSpan(
                      text:
                          'By creating a new subscription group, you agree to the following terms and conditions:\n\n',
                    ),
                    const TextSpan(
                      text: '• Rules and Instructions: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text:
                          'Users must adhere to all guidelines and instructions provided by Sharepact.\n',
                    ),
                    const TextSpan(
                      text: '• Cancellation Policy: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text:
                          'Subscription groups can be canceled at any time, but users will be responsible for any outstanding fees or charges incurred up to the cancellation date. ',
                    ),
                    TextSpan(
                      text: 'Read Full Terms and Conditions',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle tap
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                value: agreedToTerms,
                onChanged: (value) {
                  setState(() {
                    agreedToTerms = value!;
                  });
                },
                title: const Text('I agree to the Terms and Conditions'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: const Color(0xFF007BFF),
                checkColor: Colors.white,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: agreedToTerms
                      ? () {
                          // Handle create group action
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return const Color(0xFFB0D6FF);
                        }
                        return const Color(0xFF007BFF); // Use the component's default.
                      },
                    ),
                    padding: WidgetStateProperty.all<EdgeInsets>(
const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0)                    ),
                  ),
                  child: const Text('Create Group'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
