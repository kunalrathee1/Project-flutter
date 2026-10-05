// ============================================================
// AppColors – single source of truth for all design tokens.
// Match screenshots: Primary red #D71920, fresh green #2E9E4F,
// offer orange #F59E0B, background #FAF7F2, JioPrime gold #C9A227.
// ============================================================
import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand
  static const Color primary = Color(0xFFD71920); // Reliance red
  static const Color primaryDark = Color(0xFFB01318);
  static const Color primaryLight = Color(0xFFFF4B52);

  // Accent
  static const Color freshGreen = Color(0xFF2E9E4F);
  static const Color offerOrange = Color(0xFFF59E0B);
  static const Color jioPrimeGold = Color(0xFFC9A227);

  // Background
  static const Color background = Color(0xFFFAF7F2);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF3F0EB);

  // Text
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Colors.white;

  // Status
  static const Color success = Color(0xFF2E9E4F);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFDC2626);
  static const Color info = Color(0xFF3B82F6);

  // Divider / Border
  static const Color divider = Color(0xFFE5E7EB);
  static const Color border = Color(0xFFD1D5DB);

  // Card shadow
  static const Color shadow = Color(0x1A000000);

  // Shimmer
  static const Color shimmerBase = Color(0xFFE0DCE0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Disabled
  static const Color disabled = Color(0xFFD1D5DB);
  static const Color disabledText = Color(0xFF9CA3AF);

  // Specific UI
  static const Color earlyBirdSlot = Color(0xFF0EA5E9); // blue for 6-8 AM free
  static const Color stockHigh = Color(0xFF2E9E4F);
  static const Color stockLow = Color(0xFFF59E0B);
  static const Color stockOut = Color(0xFFDC2626);
}
