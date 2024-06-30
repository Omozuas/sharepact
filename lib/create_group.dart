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
                  Container(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      iconSize: 24,
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Create a New Subscription Group',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Invite friends and family to share the cost of your favorite subscriptions. Save more by creating a group and unlocking bulk discounts together',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8,
                      height: 49,
                      decoration: BoxDecoration(
                        color: Color(0xFF007BFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Please note :',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(text: 'For '),
                                TextSpan(
                                  text: 'spotify',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle tap
                                    },
                                ),
                                TextSpan(text: ' or '),
                                TextSpan(
                                  text: 'Apple music',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle tap
                                    },
                                ),
                                TextSpan(
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
              SizedBox(height: 20),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 16),
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
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                color: Color(0xFF007BFF),
                child: Text(
                  'Payment Details',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPaymentDetailRow('Subscription Cost', '5,000 NGN/Year'),
                    buildPaymentDetailRow('Handling Fee', '500 NGN'),
                    buildPaymentDetailRow('Individual Share', '1,100 NGN'),
                  ],
                ),
              ),
              Divider(),
              Text(
                'Group Privacy',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: SwitchListTile(
                  title: Text('Public'),
                  value: isPublic,
                  onChanged: (value) {
                    setState(() {
                      isPublic = value;
                    });
                  },
                  activeColor: Color(0xFF007BFF),
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
              Divider(),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'By creating a new subscription group, you agree to the following terms and conditions:\n\n',
                    ),
                    TextSpan(
                      text: '• Rules and Instructions: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Users must adhere to all guidelines and instructions provided by Sharepact.\n',
                    ),
                    TextSpan(
                      text: '• Cancellation Policy: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          'Subscription groups can be canceled at any time, but users will be responsible for any outstanding fees or charges incurred up to the cancellation date. ',
                    ),
                    TextSpan(
                      text: 'Read Full Terms and Conditions',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle tap
                        },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                value: agreedToTerms,
                onChanged: (value) {
                  setState(() {
                    agreedToTerms = value!;
                  });
                },
                title: Text('I agree to the Terms and Conditions'),
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: Color(0xFF007BFF),
                checkColor: Colors.white,
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: agreedToTerms
                      ? () {
                          // Handle create group action
                        }
                      : null,
                  child: Text('Create Group'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.disabled)) {
                          return Color(0xFFB0D6FF);
                        }
                        return Color(0xFF007BFF); // Use the component's default.
                      },
                    ),
                    padding: WidgetStateProperty.all<EdgeInsets>(
EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0)                    ),
                  ),
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
          Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
