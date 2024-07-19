import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';

class CheckboxRow extends ConsumerWidget {
  final StateProvider<bool> provider;
  final String text;
  const CheckboxRow({
    super.key,
    required this.text,
    required this.provider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkValue = ref.watch(provider);

    return Row(
      children: [
        Container(
          height: 20.0,
          width: 20.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: checkValue
                  ? Border.all(color: AppColors.primaryColor)
                  : null),
          child: Checkbox(
              value: checkValue,
              activeColor: Colors.white,
              checkColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                  color: checkValue
                      ? AppColors.primaryColor
                      : AppColors.checkBorderColor),
              onChanged: (value) {
                ref.watch(provider.notifier).state = value!;
              }),
        ),
        SizedBox(
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
