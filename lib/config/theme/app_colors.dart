import 'package:flutter/material.dart';

/// App color palette following the premium dark theme design system
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color background = Color(0xFF1a1d29);
  static const Color cardBackground = Color(0xFF252a3a);
  static const Color surfaceLight = Color(0xFF2f3447);

  // Accent Colors
  static const Color neonBlue = Color(0xFF00d4ff);
  static const Color vibrantPurple = Color(0xFFb537ff);
  static const Color accentYellow = Color(0xFFffd700);

  // Text Colors
  static const Color textPrimary = Color(0xFFffffff);
  static const Color textSecondary = Color(0xFFa0a0a0);
  static const Color textTertiary = Color(0xFF7a7a7a);

  // Border & Divider
  static const Color border = Color(0xFF3a3f4f);
  static const Color divider = Color(0xFF2a2f3f);

  // Status Colors
  static const Color success = Color(0xFF00d4ff);
  static const Color error = Color(0xFFff4444);
  static const Color warning = Color(0xFFffaa00);
  static const Color info = Color(0xFF00d4ff);

  // Gradients
  static const LinearGradient ctaGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonBlue, vibrantPurple],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [neonBlue, vibrantPurple],
  );

  // Overlay colors
  static const Color overlayDark = Color(0x80000000);
  static const Color overlayLight = Color(0x1affffff);

  // Semantic colors
  static const Color primary = neonBlue;
  static const Color secondary = vibrantPurple;
  static const Color tertiary = accentYellow;
}

