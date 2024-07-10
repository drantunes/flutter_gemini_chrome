import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black,
    dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
  ),
  textTheme: GoogleFonts.shantellSansTextTheme(),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
    ),
  ),
);

const titleStyle = TextStyle(
  fontSize: 27,
  fontWeight: FontWeight.bold,
);

const factStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w200,
  color: Colors.white,
);

const buttonStyle = TextStyle(
  fontSize: 16,
);
