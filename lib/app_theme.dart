import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: false,
      primaryColor: const Color(0xff007BFF), // Set your primary color here
      scaffoldBackgroundColor: Colors.white, // Set default Scaffold background color
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white, // Set default AppBar background color
        titleTextStyle: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), // Default AppBar title style
        iconTheme: const IconThemeData(color: Colors.black), // Default AppBar icon color
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff007BFF), // Set text color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.lato(fontSize: 16),
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.lato(fontSize: 16, color: const Color(0xff343A40)), // Set default text style
        labelLarge: GoogleFonts.lato(fontSize: 16, color: Colors.white), // Set default button text style
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white, // Set the background color of the popup menu to white
        textStyle: GoogleFonts.lato(color: Colors.black), // Set the text style of the popup menu items
      ),
    );
  }
}
