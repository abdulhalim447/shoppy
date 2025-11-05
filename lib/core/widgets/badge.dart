import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/text_styles.dart';

/// Badge types for product cards
enum BadgeType { exclusive, comingSoon, inTransit, delivered }

/// A custom badge widget for displaying product and order status
class CustomBadge extends StatelessWidget {
  final String label;
  final BadgeType type;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const CustomBadge({
    Key? key,
    required this.label,
    required this.type,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) : super(key: key);

  /// Get background color based on badge type
  Color _getBackgroundColor() {
    switch (type) {
      case BadgeType.exclusive:
        return AppColors.neonBlue.withOpacity(0.2);
      case BadgeType.comingSoon:
        return AppColors.textSecondary.withOpacity(0.2);
      case BadgeType.inTransit:
        return AppColors.vibrantPurple.withOpacity(0.2);
      case BadgeType.delivered:
        return AppColors.success.withOpacity(0.2);
    }
  }

  /// Get text color based on badge type
  Color _getTextColor() {
    switch (type) {
      case BadgeType.exclusive:
        return AppColors.neonBlue;
      case BadgeType.comingSoon:
        return AppColors.textSecondary;
      case BadgeType.inTransit:
        return AppColors.vibrantPurple;
      case BadgeType.delivered:
        return AppColors.success;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: borderRadius,
        border: Border.all(color: _getTextColor().withOpacity(0.5), width: 1),
      ),
      child: Text(
        label,
        style: AppTextStyles.labelSmall.copyWith(color: _getTextColor(), fontWeight: FontWeight.w600),
      ),
    );
  }
}
