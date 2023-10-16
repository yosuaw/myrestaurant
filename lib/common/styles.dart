import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF00ADFE);
const Color secondaryColor = Color(0xFF04E6FF);
const Color backgroundColor = Color(0xFFE7E3E3);

final TextTheme myTextTheme = TextTheme(
  headlineLarge: GoogleFonts.abrilFatface(
      fontSize: 48, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headlineMedium: GoogleFonts.abrilFatface(
      fontSize: 30, fontWeight: FontWeight.w500, letterSpacing: -0.5),
  headlineSmall:
      GoogleFonts.abrilFatface(fontSize: 24, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.abrilFatface(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  titleMedium:
      GoogleFonts.abrilFatface(fontSize: 24, fontWeight: FontWeight.w400),
  titleSmall: GoogleFonts.abrilFatface(
      fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodySmall: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.18),
  labelLarge: GoogleFonts.poppins(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  labelMedium: GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
