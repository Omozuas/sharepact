import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';

class BulletPointWidget extends StatelessWidget {
  final String text;
  final Widget? textWidget;
  const BulletPointWidget({
    super.key,
    this.text = "",
    this.textWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 5,
          width: 5,
          margin: const EdgeInsets.only(top: 5),
          decoration: const BoxDecoration(
            color: AppColors.textColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: textWidget ??
              Text(
                text,
                style: GoogleFonts.lato(
                  color: AppColors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
        ),
      ],
    );
  }
}
