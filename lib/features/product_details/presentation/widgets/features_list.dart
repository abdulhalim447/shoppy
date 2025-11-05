import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../config/constants/app_constants.dart';

/// Features list widget for product details
class FeaturesList extends StatelessWidget {
  final List<String> features;

  const FeaturesList({
    Key? key,
    required this.features,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Key Features',
          style: AppTextStyles.headlineSmall,
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Features List
        Column(
          children: List.generate(
            features.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.spacingMd),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkmark Icon
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.neonBlue.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: AppColors.neonBlue,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: AppConstants.spacingMd),

                  // Feature Text
                  Expanded(
                    child: Text(
                      features[index],
                      style: AppTextStyles.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

