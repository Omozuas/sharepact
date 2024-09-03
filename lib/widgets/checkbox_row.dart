import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';

// ignore: must_be_immutable
class CheckboxRow extends StatelessWidget {
  bool provider;
  final String text;
  void Function(bool?)? onChanged;
  CheckboxRow({
    super.key,
    required this.text,
    required this.provider,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border:
                  provider ? Border.all(color: AppColors.primaryColor) : null),
          child: Checkbox(
            value: provider,
            activeColor: Colors.white,
            checkColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(
                color: provider
                    ? AppColors.primaryColor
                    : AppColors.checkBorderColor),
            onChanged: onChanged,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: GoogleFonts.lato(
            color: AppColors.textColor02,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
