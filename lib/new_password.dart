import 'package:flutter/material.dart';
import 'package:sharepact_app/reset_successful.dart';
import 'responsive_helpers.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
 NewPasswordScreenState createState() => NewPasswordScreenState();
}

class NewPasswordScreenState extends State<NewPasswordScreen> {
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
              decoration: InputDecoration(
                hintText: 'Enter password',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xff5D6166),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xffBBC0C3), width: 1),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ResetSuccessfulScreen()),
                  );
                },
                child: const Text('Set Password'),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.02)),
          
          ],
        ),
      ),
    );
  }
}
