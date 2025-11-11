import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';

/// Order timeline widget showing order progress
class OrderTimelineWidget extends StatelessWidget {
  final String status;
  final String createdAt;
  final String updatedAt;

  const OrderTimelineWidget({Key? key, required this.status, required this.createdAt, required this.updatedAt})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statuses = ['pending', 'processing', 'completed', 'cancelled'];
    final currentIndex = statuses.indexOf(status);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        statuses.length,
        (index) => _TimelineItem(
          title: statuses[index].toUpperCase(),
          subtitle: index == 0 ? 'Created at: $createdAt' : 'Updated at: $updatedAt',
          isCompleted: index <= currentIndex,
          isLast: index == statuses.length - 1,
        ),
      ),
    );
  }
}

/// Individual timeline item
class _TimelineItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;
  final bool isLast;

  const _TimelineItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    required this.isLast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Line and Circle
        Column(
          children: [
            // Circle
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppColors.neonBlue : AppColors.surfaceLight,
                border: Border.all(color: isCompleted ? AppColors.neonBlue : AppColors.border, width: 2),
              ),
              child: isCompleted ? const Icon(Icons.check, color: AppColors.textPrimary, size: 20) : const SizedBox(),
            ),
            // Line
            if (!isLast) Container(width: 2, height: 60, color: isCompleted ? AppColors.neonBlue : AppColors.border),
          ],
        ),
        const SizedBox(width: AppConstants.spacingMd),

        // Event Content
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isCompleted ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),

                // Description
                Text(subtitle, style: AppTextStyles.bodySmallSecondary),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
