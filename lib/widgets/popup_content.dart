import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';

class PopupContentWidget extends StatelessWidget {
  final String title, actionBtnText, subtext, icon, closeBtnText;
  final VoidCallback onPressed;
  final Color buttonColor;

  const PopupContentWidget({
    super.key,
    required this.title,
    required this.actionBtnText,
    required this.onPressed,
    this.buttonColor = AppColors.primaryColor,
    required this.subtext,
    required this.icon,
    this.closeBtnText = 'Cancel',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 48,
            width: 48,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
                color: AppColors.textColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            subtext,
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppColors.textColor,
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
                backgroundColor: buttonColor,
              ),
              onPressed: onPressed,
              child: Text(actionBtnText),
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
                closeBtnText,
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
