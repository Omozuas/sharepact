import 'package:flutter/material.dart';
import 'responsive_helpers.dart';

class ResetSuccessfulScreen extends StatefulWidget {
  const ResetSuccessfulScreen({super.key});

  @override
  ResetSuccessfulScreenState createState() => ResetSuccessfulScreenState();
}

class ResetSuccessfulScreenState extends State<ResetSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/success_icon.png', // Add your success image in the assets directory and update the path
                height: responsiveHeight(context, 0.2),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.03)),
            Center(
              child: Text(
                'Password Reset Successful!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.01)),
            Center(
              child: Text(
                'Your password reset was successful. Proceed to Login',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff5D6166),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.04)),
            SizedBox(
              height: responsiveHeight(context, 0.08),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
