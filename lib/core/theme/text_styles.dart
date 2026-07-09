import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Material 3 Typography
/// Customized for Swayyam Education Foundation
class AppTextStyles {
  AppTextStyles._();

  static const TextTheme textTheme = TextTheme(

    // Large page headings
    displayLarge: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),

    // Screen titles
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),

    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: AppColors.textPrimary,
    ),

    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    ),

    // Section titles
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    titleSmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimary,
    ),

    // Normal text
    bodyLarge: TextStyle(
      fontSize: 16,
      color: AppColors.textPrimary,
    ),

    bodyMedium: TextStyle(
      fontSize: 14,
      color: AppColors.textPrimary,
    ),

    bodySmall: TextStyle(
      fontSize: 12,
      color: AppColors.textSecondary,
    ),

    // Buttons
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.textLight,
    ),

    // Small labels
    labelMedium: TextStyle(
      fontSize: 14,
      color: AppColors.textSecondary,
    ),
  );
}