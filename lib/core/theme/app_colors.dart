import 'package:flutter/material.dart';

/// Central color palette for the entire application.
/// Every color used in the app should come from here.
class AppColors {
  AppColors._();

  // ==========================================================
  // SWAYYAM EDUCATION BRAND COLORS
  // ==========================================================

  static const Color swayyamGreen = Color(0xFF0B6E4F);
  static const Color swayyamBlue = Color(0xFF243B7B);
  static const Color cubsOrange = Color(0xFFF58220);

  // ==========================================================
  // BACKGROUND COLORS
  // ==========================================================

  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Colors.white;

  // ==========================================================
  // TEXT COLORS
  // ==========================================================

  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Colors.white;

  // ==========================================================
  // STATUS COLORS
  // ==========================================================

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFD32F2F);

  // ==========================================================
  // BORDER & DIVIDER
  // ==========================================================

  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFEEEEEE);
}