import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/authScreen/reset_successful.dart';
import '../../responsive_helpers.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add form key
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    });
  }

  Future<void> changepassword() async {
    if (_formKey.currentState?.validate() ?? false) {
      final String newPassword = newPasswordController.text.trim();
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
          child: Form(
            key: _formKey,
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
                TextFormField(
                  controller: newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your newpassword';
                    }
                    return null;
                  },
                  obscureText: _isPasswordObscured,
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
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: _togglePasswordVisibility,
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
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: _isConfirmPasswordObscured,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your newpassword';
                    }
                    if (value != newPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Re-type password',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xff5D6166),
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: const EdgeInsets.all(20),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordObscured
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: _toggleConfirmPasswordVisibility,
                    ),
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
      ),
    );
  }
}
