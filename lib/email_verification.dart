import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharepact_app/verfication_successful.dart';
import 'responsive_helpers.dart';
class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Email Verification',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff343A40),
                ),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.02)),
            Center(
              child: Text(
                'A 6-digit verification code has been sent to your email address. Enter the 6-digit code below to continue',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff5D6166),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.04)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) => _buildOTPBox(context)),
            ),
            SizedBox(height: responsiveHeight(context, 0.05)),
            SizedBox(
              height: responsiveHeight(context, 0.08),
              child: ElevatedButton(
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VerificationSuccessfulScreen()),
                  );
                },
                child: const Text('Verify OTP'),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.02)),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Didn’t receive any code? ',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff343A40),
                  ),
                  children: [
                    TextSpan(
                      text: 'Resend',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Handle resend action
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPBox(BuildContext context) {
    return Container(
      width: responsiveWidth(context, 0.12),
      height: responsiveWidth(context, 0.12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffBBC0C3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '', // Hide the counter text
          ),
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          maxLengthEnforcement: MaxLengthEnforcement.none,
        ),
      ),
    );
  }
}
