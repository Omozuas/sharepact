import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  final Widget? trailing;
  final String headerText;
  final String? Function(String?)? validator;
  final String hintText;
  final TextStyle? style;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? leading;
  final TextStyle? hintStyle;
  final bool password;
  final void Function()? trailingTapped;
  final void Function()? onTap;
  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  final Color? borderColor;
  final double? borderWidth;
  final bool removeSpace;
  final bool readOnly;
  final BoxConstraints? constraints;

  AppInputField({
    super.key,
    this.validator,
    required this.headerText,
    this.controller,
    this.keyboardType,
    this.trailing,
    required this.hintText,
    this.leading,
    this.hintStyle,
    this.password = false,
    this.style,
    this.trailingTapped,
    this.onTap,
    this.borderColor,
    this.borderWidth,
    this.removeSpace = false,
    this.readOnly = false,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          headerText,
          style: style,
        ),
        SizedBox(height: height * 0.008),
        TextFormField(
          onTap: onTap,
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: password,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(14),
            prefixIcon: leading,
            prefixIconConstraints:
                readOnly ? BoxConstraints(minWidth: width * .12) : constraints,
            suffixIconConstraints:
                readOnly ? BoxConstraints(minWidth: width * .1) : constraints,
            suffixIcon: trailing != null
                ? GestureDetector(
                    onTap: trailingTapped,
                    child: trailing,
                  )
                : null,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xff007BFF),
                  width: borderWidth ?? 1,
                )),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: borderWidth ?? 1,
                  color: Colors.red,
                )),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: borderWidth ?? 1,
                )),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: borderWidth ?? 1,
                  color: Colors.red,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: const Color(0xff343A40),
                  width: borderWidth ?? 1,
                )),
            hintText: hintText,
          ),
        ),
        removeSpace ? Container() : SizedBox(height: height * 0.023),
      ],
    );
  }
}
