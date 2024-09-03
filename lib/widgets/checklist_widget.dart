import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';

class CheckListWidget extends StatelessWidget {
  final String text;
  const CheckListWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppImages.checkIcon),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              //
              style: GoogleFonts.lato(
                color: AppColors.textColor01,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
