import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/screens/home/controllerNav.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'responsive_helpers.dart';

class SupportScreen extends ConsumerStatefulWidget {
  const SupportScreen({super.key});

  @override
  ConsumerState createState() => SupportScreenState();
}

class SupportScreenState extends ConsumerState<SupportScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  Future<void> _post() async {
    final String email = emailController.text;
    final String userNmae = usernameController.text;
    final String message = messageController.text;
    if (email.isEmpty) {
      showErrorPopup(message: "email is required", context: context);
      return;
    }
    if (message.isEmpty) {
      showErrorPopup(message: "message is required", context: context);
      return;
    }
    if (userNmae.isEmpty) {
      showErrorPopup(message: "userName is required", context: context);
      return;
    }
    try {
      await ref
          .read(profileProvider.notifier)
          .contactService(name: userNmae, email: email, message: message);

      final pUpdater = ref.read(profileProvider).contactService;
      // Navigate to home screen if login is successful

      if (mounted) {
        if (pUpdater.value != null) {
          // Safely access message
          final message = pUpdater.value?.message;
          // Check if the response code is 200
          if (pUpdater.value!.code == 200) {
            // Navigate to homescreen if signin is successful

            showSuccess(message: message!, context: context);
            emailController.clear();
            usernameController.clear();
            messageController.clear();
            return;
          } else {
            showErrorPopup(message: message, context: context);
            return;
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
    final isLoading = ref.watch(profileProvider).contactService.isLoading;
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const ControllerNavScreen(
                      initialIndex: 3,
                    )));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ControllerNavScreen(
                            initialIndex: 3,
                          )));
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(context, 0.06)),
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
                  controller: messageController,
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
                    onPressed: isLoading ? () {} : _post,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Submit'),
                  ),
                ),
                SizedBox(height: responsiveHeight(context, 0.01)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
