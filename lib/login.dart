import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/reset_password.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'package:sharepact_app/screens/home/home.dart';
import 'package:sharepact_app/signup.dart';
import 'responsive_helpers.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final AuthService _authService = AuthService();

  bool _isPasswordObscured = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  Future<void> _login() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    if (email.isEmpty) {
      showErrorPopup(message: "email is required", context: context);
      return;
    }
    if (password.isEmpty) {
      showErrorPopup(message: "password is required", context: context);
      return;
    }
    try {
      await ref
          .read(profileProvider.notifier)
          .loginUser(email: email, password: password);

      final pUpdater = ref.read(profileProvider).login;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ControllerNavScreen()),
            );
            showSuccess(message: message!, context: context);
          } else {
            showErrorPopup(message: message, context: context);
          }
        }
      }
    } catch (e) {
      // Show error if login fails
      if (mounted) {
        showErrorPopup(
            message: e.toString().replaceAll('Exception: ', ''),
            context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).login.isLoading;
    // ignore: deprecated_member_use
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: responsiveWidth(context, 0.06)),
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
                      'Welcome Back!',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.01)),
                  Center(
                    child: Text(
                      'Login to start with SharePact',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff5D6166),
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.04)),
                  Text(
                    'Email',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.005)),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email address',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xff5D6166),
                              ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Color(0xffBBC0C3), width: 1),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.02)),
                  Text(
                    'Password',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.005)),
                  TextField(
                    controller: passwordController,
                    obscureText: _isPasswordObscured,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xff5D6166),
                              ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ResetPasswordScreen()),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.04)),
                  SizedBox(
                    height: responsiveHeight(context, 0.08),
                    child: ElevatedButton(
                      onPressed: isLoading ? () {} : _login,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    ),
                  ),
                  SizedBox(height: responsiveHeight(context, 0.02)),
                  RichText(
                    text: TextSpan(
                      text: 'Don\'t have an account? ',
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                        ),
                      ],
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                          ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
