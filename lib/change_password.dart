import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/api/snackbar/snackbar_respones.dart';
import 'package:sharepact_app/login.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'responsive_helpers.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ChangePasswordScreenState();
}

class ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> checkStatus() async {
    final String currentPassword = currentPasswordController.text;
    final String newPassword = newPasswordController.text;
    final String confirmNewPassword = confirmPasswordController.text;

    if (currentPassword.isEmpty) {
      showErrorPopup(message: "Current password is required", context: context);
      return;
    }
    if (newPassword.isEmpty) {
      showErrorPopup(message: "New password is required", context: context);
      return;
    }
    if (newPassword != confirmNewPassword) {
      showErrorPopup(message: "Passwords do not match", context: context);
      return;
    }
    _updatePassword(newPassword: newPassword, currentPassword: currentPassword);
  }

  Future<void> _updatePassword(
      {required String newPassword, required String currentPassword}) async {
    print({newPassword, currentPassword});
    try {
      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      print(myToken);
      await ref
          .read(profileProvider.notifier)
          .checkTokenStatus(token: myToken!);
      final isTokenValid = ref.read(profileProvider).checkTokenstatus.value;

      if (isTokenValid!.code != 200) {
        _handleSessionExpired();
        return;
      }

      await ref.read(profileProvider.notifier).changeProfilePassword(
            currentPassword: currentPassword,
            newPassword: newPassword,
          );

      final pUpdater = ref.read(profileProvider).changeProfilePassword;

      if (mounted && pUpdater.value != null) {
        final message = pUpdater.value?.message ?? 'Password update failed';

        if (pUpdater.value!.code == 200) {
          showSuccess(message: message, context: context);
          logOut();
        } else {
          showErrorPopup(message: message, context: context);
        }
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> logOut() async {
    try {
      final tokenValid =
          await ref.read(profileProvider.notifier).validateToken();
      if (!tokenValid) {
        _handleSessionExpired();
        return;
      }

      await ref.read(profileProvider.notifier).getToken();
      final myToken = ref.read(profileProvider).getToken.value;
      if (myToken != null && myToken.isNotEmpty) {
        await ref.read(profileProvider.notifier).logOut(token: myToken);
        final pUpdater = ref.read(profileProvider).logout;

        if (mounted && pUpdater.value != null) {
          final message = pUpdater.value?.message ?? 'Logout failed';

          if (pUpdater.value!.code == 200) {
            await _clearSessionData();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          } else {
            showErrorPopup(message: message, context: context);
          }
        } else {
          showErrorPopup(
              message: "Logout failed. Please try again.", context: context);
        }
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _clearSessionData() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
  }

  void _handleSessionExpired() {
    if (mounted) {
      showErrorPopup(message: 'Session expired', context: context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _handleError(e) {
    if (mounted) {
      showErrorPopup(
        message: e.toString().replaceAll('Exception: ', ''),
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading1 = ref.watch(profileProvider).logout.isLoading;
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
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(
                height: 20,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Current Password',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: responsiveHeight(context, 0.005)),
              TextField(
                controller: currentPasswordController,
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
              const SizedBox(
                height: 10,
              ),
              Text(
                'New Password',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: responsiveHeight(context, 0.005)),
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  hintText: 'Re-type password',
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
              const SizedBox(
                height: 10,
              ),
              Text(
                'Confirm New Password',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              SizedBox(height: responsiveHeight(context, 0.005)),
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Re-type password',
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
              SizedBox(height: responsiveHeight(context, 0.04)),
              SizedBox(
                height: responsiveHeight(context, 0.08),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return LogOutAfterUpdateDialog(
                              text: const Text('continnue'),
                              onTap: () {
                                checkStatus();
                                Navigator.pop(ctx);
                              });
                        });
                  },
                  child: isLoading1
                      ? const Text('loggingout...')
                      : const Text('Save New Password'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LogOutAfterUpdateDialog extends ConsumerStatefulWidget {
  const LogOutAfterUpdateDialog(
      {super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final Widget text;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LogOutAfterUpdateDialogState();
}

class _LogOutAfterUpdateDialogState
    extends ConsumerState<LogOutAfterUpdateDialog> {
  @override
  Widget build(BuildContext context) {
    final isLoading =
        ref.watch(profileProvider).changeProfilePassword.isLoading;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Update password",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 28 / 18,
                color: const Color(0xFF0F172A),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            Text(
              'Your account will logout  after password update',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 20 / 14,
                color: const Color(0xFF64748B),
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: responsiveHeight(context, 0.05),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancle'),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: responsiveHeight(context, 0.05),
                  child: ElevatedButton(
                    onPressed: isLoading ? () {} : widget.onTap,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : widget.text,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
