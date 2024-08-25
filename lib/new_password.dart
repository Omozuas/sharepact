import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/reset_successful.dart';
import 'responsive_helpers.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  const NewPasswordScreen({super.key, this.code, this.email});
  final String? email, code;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      NewPasswordScreenState();
}

class NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  Future<void> changepassword() async {
    final String newPassword = newPasswordController.text.trim();
    final String confirmPassword = confirmPasswordController.text.trim();
    if (newPassword.isEmpty) {
      showErrorPopup(message: "password is required", context: context);
      return;
    }
    if (confirmPassword.isEmpty) {
      showErrorPopup(message: "confirmPassword is required", context: context);
      return;
    }
    if (newPassword != confirmPassword) {
      // Show error if passwords do not match
      showErrorPopup(message: 'Passwords do not match', context: context);
      return;
    }
    try {
      await ref.read(profileProvider.notifier).changePassword(
          email: widget.email!, password: newPassword, code: widget.code!);

      final pUpdater = ref.read(profileProvider).changePassword;
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
                  builder: (context) => const ResetSuccessfulScreen()),
            );
          } else {
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
      if (mounted) {
        showErrorPopup(message: 'an err occored $e ', context: context);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).changePassword.isLoading;
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
      body: SingleChildScrollView(
        child: Padding(
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
                  'Create a New Password',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.01)),
              Center(
                child: Text(
                  'Enter your new password twice to confirm',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff5D6166),
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.04)),
              Text(
                'New password',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: responsiveHeight(context, 0.005)),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xff5D6166),
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide:
                        const BorderSide(color: Color(0xffBBC0C3), width: 1),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.02)),
              Text(
                'Confirm new password',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: responsiveHeight(context, 0.005)),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Re-type password',
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: const Color(0xff5D6166),
                      ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.04)),
              SizedBox(
                height: responsiveHeight(context, 0.08),
                child: ElevatedButton(
                  onPressed: isLoading ? () {} : changepassword,
                  child: const Text('Set Password'),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.02)),
            ],
          ),
        ),
      ),
    );
  }
}
