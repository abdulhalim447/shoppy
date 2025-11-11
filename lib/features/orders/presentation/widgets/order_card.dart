import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../core/widgets/badge.dart';
import '../../data/models/order_history_model.dart';

/// Order card widget for order history
class OrderCard extends StatelessWidget {
  final OrderHistoryModel order;
  final VoidCallback? onTap;

  const OrderCard({Key? key, required this.order, this.onTap}) : super(key: key);

  /// Get badge type based on order status
  BadgeType _getBadgeType(String status) {
    switch (status) {
      case 'pending':
        return BadgeType.exclusive;
      case 'processing':
        return BadgeType.inTransit;
      case 'completed':
        return BadgeType.delivered;
      case 'cancelled':
        return BadgeType.comingSoon;
      default:
        return BadgeType.exclusive;
    }
  }

  /// Get status label
  String _getStatusLabel(String status) {
    return status.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.spacingMd),
        margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Header
            Row(
              children: [
                // Product Image
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                    color: AppColors.accentYellow,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                    child: Image.network(
                      order.product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.shopping_bag);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.spacingMd),

                // Order Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID
                      Text('#${order.id}', style: AppTextStyles.labelMedium.copyWith(color: AppColors.textSecondary)),
                      const SizedBox(height: 4),

                      // Product Name
                      Text(
                        order.product.name,
                        style: AppTextStyles.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Order Date
                      Text(order.createdAt.toString().split(' ')[0], style: AppTextStyles.bodySmallSecondary),
                    ],
                  ),
                ),

                // Status Badge
                CustomBadge(label: _getStatusLabel(order.status), type: _getBadgeType(order.status)),
              ],
            ),
            const SizedBox(height: AppConstants.spacingMd),

            // Estimated Delivery
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Last Updated', style: AppTextStyles.bodySmallSecondary),
                Text(
                  order.updatedAt.toString().split(' ')[0],
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.neonBlue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
