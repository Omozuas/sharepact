import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'responsive_helpers.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  SupportScreenState createState() => SupportScreenState();
}

class SupportScreenState extends State<SupportScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Support",
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
              "Contact Support",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                color: AppColors.textColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Have any questions or concerns? Kindly fill out the form below, and we will get back to you as soon as possible to resolve your issue',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff5D6166),
                  fontSize: 14),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Name',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Enter name",
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
            const SizedBox(height: 20),
            Text(
              'Email Address',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter your email address',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xff5D6166),
                    ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Issue description',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              minLines: 7,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: 'Type your message here',
                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xff5D6166),
                    ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                contentPadding: const EdgeInsets.all(20),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: responsiveHeight(context, 0.08),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ),
            SizedBox(height: responsiveHeight(context, 0.01)),
          ],
        ),
      ),
    );
  }
}
