import 'package:flutter/material.dart';
import 'package:sharepact_app/signup.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'responsive_helpers.dart';
import 'responsive_onboarding.dart'; // Import the responsive onboarding page

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              ResponsiveOnboardingPage(
                image: 'assets/onboarding11.png',
                title: 'Welcome to SharePact!',
                description: 'Join forces with friends and family to save on your favorite subscriptions. Discover how SharePact makes it easy and affordable!',
              ),
              ResponsiveOnboardingPage(
                image: 'assets/onboarding12.png',
                title: 'Easy Group Management',
                description: 'Create or join groups effortlessly. Manage shared subscriptions with real-time updates and secure payments.',
              ),
              ResponsiveOnboardingPage(
                image: 'assets/onboarding13.png',
                title: 'Enjoy More for Less',
                description: 'Unlock bulk discounts and shared costs. Enjoy premium services without the premium price tag.',
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: responsiveHeight(context, 0.10), left: 20, right: 20), // Adjusted bottom padding
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: CustomizableEffect(
                      activeDotDecoration: DotDecoration(
                        width: 50,
                        height: 4,
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      dotDecoration: DotDecoration(
                        width: 50,
                        height: 4,
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(16),
                        verticalOffset: 0,
                      ),
                      spacing: 6.0,
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.05)), // Space between indicator and button
                  SizedBox(
                    width: double.infinity,
                    height: responsiveHeight(context, 0.08),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                      child: const Text('Get Started'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
