import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';




class GroupMemberWidget extends StatelessWidget {
  final String image, name;
  final bool isActive;

  const GroupMemberWidget({
    super.key,
    required this.image,
    required this.name,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: AppColors.lightBlue01,
                child: Image.asset(
                  image,
                  width: 32,
                  height: 32,
                ),
              )),
          const SizedBox(
            width: 5,
          ),
          Text(
            name,
            style: GoogleFonts.lato(
              color: AppColors.textColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Container(
            width: 90,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: isActive ? AppColors.lightGreen : AppColors.lightPink,
            ),
            child: Center(
              child: Text(
                isActive ? 'Active' : "Inactive",
                style: GoogleFonts.lato(
                  color: isActive ? AppColors.green : AppColors.pink,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
