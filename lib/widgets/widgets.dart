import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/api/riverPod/provider.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';

class PopupContentWidget extends ConsumerStatefulWidget {
  final String title, actionBtnText;
  final VoidCallback onPressed;
  final Color buttonColor;
  const PopupContentWidget({
    super.key,
    required this.title,
    required this.actionBtnText,
    required this.onPressed,
    this.buttonColor = AppColors.primaryColor,
  });

  @override
  ConsumerState createState() => PopupContentWidgetState();
}

class PopupContentWidgetState extends ConsumerState<PopupContentWidget> {
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(profileProvider).logout.isLoading;

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppColors.textColor02,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonColor,
              ),
              onPressed: isLoading ? () {} : widget.onPressed,
              child: Text(isLoading ? "Logging Out" : widget.actionBtnText),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.lato(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PopupContentWidget1 extends ConsumerStatefulWidget {
  final String title, actionBtnText;
  final VoidCallback onPressed;
  final Color buttonColor;
  const PopupContentWidget1({
    super.key,
    required this.title,
    required this.actionBtnText,
    required this.onPressed,
    this.buttonColor = AppColors.primaryColor,
  });

  @override
  ConsumerState createState() => PopupContentWidgetState();
}

class PopupContent1WidgetState extends ConsumerState<PopupContentWidget> {
  @override
  Widget build(BuildContext context) {
    final isDeleting = ref.watch(profileProvider).deleteAccount.isLoading;

    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppColors.textColor02,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.buttonColor,
              ),
              onPressed: isDeleting ? () {} : widget.onPressed,
              child: Text(isDeleting ? "Deletin..." : widget.actionBtnText),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.lato(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsTile extends StatelessWidget {
  final Widget icon;
  final String title;
  final VoidCallback onTap;

  const SettingsTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon,
      title: Text(title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: const Color(0xff5D6166),
              )),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
