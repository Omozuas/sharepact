import 'package:flutter/material.dart';
import 'package:sharepact_app/available_groups.dart';
import 'package:sharepact_app/create_group.dart';

class NetflixDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button action
          },
        ),
        title: Text('Netflix'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 343,
                height: 178,
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: ClipOval(
                    child: Container(
                      color: Colors.black,
                      child: Image.asset(
                        'assets/netflix.png',
                        width: 120,
                        height: 120,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: Text(
                'Netflix offers a diverse range of subscription plans to cater to different viewing needs and preferences. The Basic Plan allows streaming on one screen at a time, while the Standard Plan offers HD viewing on two screens.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: Text(
                'For families and enthusiasts, the Premium Plan provides Ultra HD quality on up to four screens simultaneously. Enjoy unlimited access to movies, TV shows, and original content with the flexibility to cancel anytime.',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Available Subscription Plans',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            PlanCard(
              planName: 'Basic Plan',
              price: '5000 NGN/ month',
              features: [
                'Watch on 1 screen at a time',
                'Unlimited movies and TV shows',
                'Cancel anytime',
              ],
            ),
            PlanCard(
              planName: 'Standard Plan',
              price: '10,000 NGN/ month',
              features: [
                'Watch on 2 screens at a time',
                'HD available',
                'Unlimited movies and TV shows',
                'Cancel anytime',
              ],
            ),
            PlanCard(
              planName: 'Premium Plan',
              price: '20,000 NGN/ month',
              features: [
                'Watch on 4 screens at a time',
                'Ultra HD available',
                'Unlimited movies and TV shows',
                'Cancel anytime',
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 49,
                    color: Color(0xFF007BFF),
                  ),
                  SizedBox(width: 10.0),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Sharepact Handling Fee: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text: '1,000 NGN/ month',
                          style: TextStyle(
                            color: Color(0xFF007BFF),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  OutlinedButton(
                    onPressed: () {
                           Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  AvailableGroupsScreen()),
                  );
                    },
                    child: Text(
                      'Join A Group',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF007BFF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(339, 59),
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      side: BorderSide(color: Color(0xFF007BFF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  OutlinedButton(
                    onPressed: () {
                        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  CreateGroupScreen()),
                  );
                    },
                    child: Text(
                      'Create A Group',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xFF007BFF),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size(339, 59),
                      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
                      side: BorderSide(color: Color(0xFF007BFF)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final String planName;
  final String price;
  final List<String> features;

  PlanCard({required this.planName, required this.price, required this.features});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      planName,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: price.split('/')[0],
                            style: TextStyle(
                              color: Color(0xFF007BFF),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: ' /${price.split('/')[1]}',
                            style: TextStyle(
                              color: Color(0xFF5D6166),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: features.map((feature) => FeatureItem(text: feature)).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String text;

  FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.blue,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
