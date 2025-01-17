import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/authScreen/new_password.dart';
import '../../responsive_helpers.dart';

class OTPScreen extends ConsumerStatefulWidget {
  const OTPScreen({super.key, this.email});
  final String? email;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => OTPScreenState();
}

class OTPScreenState extends ConsumerState<OTPScreen> {
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  @override
  void dispose() {
    // Dispose of the controllers to avoid memory leaks.
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> confirmReSetPasswordCode() async {
    String otp = otpControllers.map((controller) => controller.text).join();
    // Check if OTP is empty
    if (otp.isEmpty) {
      showErrorPopup(message: "Please Enter Your OTP PIN", context: context);
      return; // Exit the function if OTP is empty
    }
    try {
      await ref
          .read(profileProvider.notifier)
          .confirmReSetPassword(email: widget.email!, code: otp);
      final pUpdater = ref.read(profileProvider).confirmReSetPassword;
      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;

          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            showSuccess(message: message!, context: context);
            // Navigate to email NewPasswordScreen if signup is successful
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewPasswordScreen(
                        code: otp,
                        email: widget.email,
                      )),
            );
          }
          final emailErrors = pUpdater.value?.code;
          if (emailErrors == 400) {
            showErrorPopup(message: message, context: context);
            return;
          }
        } else {
          showErrorPopup(
              message: "An unknown error occurred", context: context);
          return;
        }
      }
    } catch (e) {
      // Show error if signup fails
      if (mounted) {
        showErrorPopup(message: 'an err occored $e ', context: context);
        return;
      }
    }
  }

  Future<void> reSendPasswordCode() async {
    try {
      await ref.read(profileProvider.notifier).reSetPasword(
            email: widget.email!,
          );
      final pUpdater = ref.read(profileProvider).resetPassword;
      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;

          // Check if the response code is 201
          if (pUpdater.value!.code == 200) {
            showSuccess(message: message!, context: context);
            // Navigate to email verification screen if signup is successful
            return;
          }
          final emailErrors = pUpdater.value?.code;
          if (emailErrors == 400) {
            showErrorPopup(message: message, context: context);
            return;
          }
        } else {
          showErrorPopup(
              message: "An unknown error occurred", context: context);
          return;
        }
      }
    } catch (e) {
      // Show error if signup fails
      if (mounted) {
        showErrorPopup(message: 'an err occored $e ', context: context);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).confirmReSetPassword.isLoading;
    final isLoading1 = ref.watch(profileProvider).resetPassword.isLoading;

    // ignore: deprecated_member_use
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
        padding:
            EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: responsiveHeight(context, 0.02)),
            Center(
              child: Image.asset(
                'assets/sharepact_icon.png', // Add your logo image in the assets directory and update the path
                height: responsiveHeight(context, 0.08),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.03)),
            Center(
              child: Text(
                'Enter One-Time Password',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.01)),
            Center(
              child: Text(
                'Check your email for the OTP and enter it below to continue with resetting your password',
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
              children: List.generate(
                  6, (index) => _buildOTPBox(context, index, otpControllers)),
            ),
            SizedBox(height: responsiveHeight(context, 0.05)),
            SizedBox(
              height: responsiveHeight(context, 0.08),
              child: ElevatedButton(
                onPressed: isLoading ? () {} : confirmReSetPasswordCode,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Verify OTP'),
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
                      text: isLoading1 ? 'Resending...' : 'Resend',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = isLoading1
                            ? () {
                                // Handle resend action
                              }
                            : reSendPasswordCode,
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

  Widget _buildOTPBox(BuildContext context, index, controller) {
    return Container(
      width: responsiveWidth(context, 0.12),
      height: responsiveWidth(context, 0.12),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffBBC0C3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          controller: controller[index],
          autofocus: index == 0,
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
            // Hide the counter text
          ),
          onChanged: (value) {
            if (value.length == 1 && index < 6) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && index > 0) {
              FocusScope.of(context).previousFocus();
            }
          },
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
