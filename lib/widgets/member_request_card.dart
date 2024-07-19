import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';
import 'package:sharepact_app/utils/app_images/app_images.dart';


class MemberRequestCard extends StatelessWidget {
  const MemberRequestCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 161,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: AppColors.lightBlue01,
                child: Image.asset(
                  AppImages.avatarImage3,
                  width: 64,
                  height: 64,
                ),
              )),
          Text(
            "JohnDoe2",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppColors.textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(),
          Text(
            "Hi creator! I’d like to join your group",
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              color: AppColors.textColor,
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Divider(),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 1,
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {},
              child: const Text("Accept"),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 30,
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
              onPressed: () {},
              child: Text(
                "Decline",
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