import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../checkout/data/models/order_model.dart' as order_models;

/// Order timeline widget showing order progress
class OrderTimelineWidget extends StatelessWidget {
  final List<order_models.OrderTimeline> timeline;

  const OrderTimelineWidget({Key? key, required this.timeline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        timeline.length,
        (index) => _TimelineItem(event: timeline[index], isLast: index == timeline.length - 1, isFirst: index == 0),
      ),
    );
  }
}

/// Individual timeline item
class _TimelineItem extends StatelessWidget {
  final order_models.OrderTimeline event;
  final bool isLast;
  final bool isFirst;

  const _TimelineItem({Key? key, required this.event, required this.isLast, required this.isFirst}) : super(key: key);

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
                color: event.isCompleted ? AppColors.neonBlue : AppColors.surfaceLight,
                border: Border.all(color: event.isCompleted ? AppColors.neonBlue : AppColors.border, width: 2),
              ),
              child: event.isCompleted
                  ? const Icon(Icons.check, color: AppColors.textPrimary, size: 20)
                  : const SizedBox(),
            ),
            // Line
            if (!isLast)
              Container(width: 2, height: 60, color: event.isCompleted ? AppColors.neonBlue : AppColors.border),
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
                  event.title,
                  style: AppTextStyles.titleMedium.copyWith(
                    color: event.isCompleted ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),

                // Description
                Text(event.description, style: AppTextStyles.bodySmallSecondary),
                const SizedBox(height: 4),

                // Timestamp
                Text(event.timestamp.toString().split('.')[0], style: AppTextStyles.caption),
                if (!isLast) const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
