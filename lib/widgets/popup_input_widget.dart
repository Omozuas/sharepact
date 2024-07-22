

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sharepact_app/utils/app_colors/app_colors.dart';

class PopupInputWidget extends StatefulWidget {
  final TextEditingController textController;
  final VoidCallback onPressed;
  final int? minLines, height;
  final String title, subtext, hintText, btnText;
  final bool obscureText;

  const PopupInputWidget({super.key, required this.textController, required this.onPressed,  this.minLines,  this.hintText = "", required this.title, required this.subtext, required this.btnText, this.obscureText = false, this.height = 230});

  @override
  State<PopupInputWidget> createState() => _PopupInputWidgetState();
}

class _PopupInputWidgetState extends State<PopupInputWidget> {

    bool _isPasswordObscured = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }
@override
  void initState() {
    _isPasswordObscured = widget.obscureText;
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
              height: widget.height!.toDouble(),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subtext,
                     textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: AppColors.textColor02,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                     widget.title,
                    
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: AppColors.textColor02,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextField(
                    controller: widget.textController,
                    obscureText: _isPasswordObscured,
                    minLines: widget.minLines,
                    maxLines:  widget.minLines,
                    decoration: InputDecoration(
                      hintText: widget.hintText,
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: const Color(0xff5D6166),
                              ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: widget.obscureText ? IconButton(
                        icon: Icon(
                          _isPasswordObscured
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ) : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                      ),
                      onPressed: widget.onPressed,
                      child:  Text(widget.btnText),
                    ),
                  ),
                ],
              ),
            );
  }
}