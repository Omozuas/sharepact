import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sharepact_app/api/auth_service.dart';
import 'package:sharepact_app/email_verification.dart';
import 'package:sharepact_app/login.dart';
import 'responsive_helpers.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final AuthService _authService = AuthService();

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

  void _signup() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      // Show error if passwords do not match
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final response = await _authService.signup(email, password);
      // Navigate to email verification screen if signup is successful
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const EmailVerificationScreen()),
      );
    } catch (e) {
      // Show error if signup fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding:
              EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: responsiveHeight(context, 0.02)),
              Center(
                child: Image.asset(
                  'assets/sharepact_icon.png',
                  height: responsiveHeight(context, 0.08),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.03)),
              Center(
                child: Text(
                  'Create Account',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.01)),
              Center(
                child: Text(
                  'Fill in your details to register with SharePact',
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
                  hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
              SizedBox(height: responsiveHeight(context, 0.02)),
              Text(
                'Confirm Password',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: responsiveHeight(context, 0.005)),
              TextField(
                controller: confirmPasswordController,
                obscureText: _isConfirmPasswordObscured,
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
                  onPressed: _signup,
                  child: const Text('Sign Up'),
                ),
              ),
              SizedBox(height: responsiveHeight(context, 0.02)),
              RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Login',
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
                                builder: (context) => const LoginScreen()),
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
    );
  }
}
