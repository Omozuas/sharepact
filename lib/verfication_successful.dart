import 'package:flutter/material.dart';
import 'package:sharepact_app/screens/authScreen/login.dart';
import 'responsive_helpers.dart';

class VerificationSuccessfulScreen extends StatefulWidget {
  const VerificationSuccessfulScreen({super.key});

  @override
  VerificationSuccessfulScreenState createState() =>
      VerificationSuccessfulScreenState();
}

class VerificationSuccessfulScreenState
    extends State<VerificationSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
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
                'Verification Successful!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.01)),
            Center(
              child: Text(
                'Your email has been successfully verified. Login to access your SharePact account',
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
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
