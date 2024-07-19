import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'responsive_helpers.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Manage Password",
          style: GoogleFonts.lato(
            color: AppColors.textColor,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: responsiveWidth(context, 0.06)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'To change your password, enter your current password followed by your new password twice for confirmation',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff5D6166),
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(height: 10,),
            Text(
              'Current Password',
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
            SizedBox(height: 10,),
            Text(
              'New Password',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: responsiveHeight(context, 0.005)),
           TextField(
              decoration: InputDecoration(
                hintText: 'Re-type password',
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
            SizedBox(height: 10,),
            Text(
              'Confirm New Password',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(height: responsiveHeight(context, 0.005)),
           TextField(
              decoration: InputDecoration(
                hintText: 'Re-type password',
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
               SizedBox(height: responsiveHeight(context, 0.04)),
            SizedBox(
                height: responsiveHeight(context, 0.08),
            
              child: ElevatedButton(
                  onPressed: () {
                       },
                  child: const Text('Save New Password'),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
