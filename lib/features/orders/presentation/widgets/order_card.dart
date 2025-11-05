import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../config/constants/app_constants.dart';
import '../../../../core/widgets/badge.dart';
import '../../../checkout/data/models/order_model.dart';

/// Order card widget for order history
class OrderCard extends StatelessWidget {
  final OrderModel order;
  final VoidCallback? onTap;

  const OrderCard({
    Key? key,
    required this.order,
    this.onTap,
  }) : super(key: key);

  /// Get badge type based on order status
  BadgeType _getBadgeType(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return BadgeType.exclusive;
      case OrderStatus.processing:
        return BadgeType.inTransit;
      case OrderStatus.outForDelivery:
        return BadgeType.inTransit;
      case OrderStatus.delivered:
        return BadgeType.delivered;
      case OrderStatus.cancelled:
        return BadgeType.comingSoon;
    }
  }

  /// Get status label
  String _getStatusLabel(OrderStatus status) {
    switch (status) {
      case OrderStatus.placed:
        return 'Order Placed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstItem = order.items.isNotEmpty ? order.items.first : null;

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
                if (firstItem?.productImage != null)
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
                        firstItem!.productImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.shopping_bag);
                        },
                      ),
                    ),
                  )
                else
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                      color: AppColors.surfaceLight,
                    ),
                    child: const Icon(Icons.shopping_bag),
                  ),
                const SizedBox(width: AppConstants.spacingMd),

                // Order Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order ID
                      Text(
                        order.orderId,
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Product Name
                      Text(
                        firstItem?.productName ?? 'Order',
                        style: AppTextStyles.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Order Date
                      Text(
                        order.orderDate.toString().split(' ')[0],
                        style: AppTextStyles.bodySmallSecondary,
                      ),
                    ],
                  ),
                ),

                // Status Badge
                CustomBadge(
                  label: _getStatusLabel(order.status),
                  type: _getBadgeType(order.status),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.spacingMd),

            // Estimated Delivery
            if (order.estimatedDeliveryDate != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Estimated Delivery',
                    style: AppTextStyles.bodySmallSecondary,
                  ),
                  Text(
                    order.estimatedDeliveryDate!.toString().split(' ')[0],
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.neonBlue,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

