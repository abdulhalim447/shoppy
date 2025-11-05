import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../config/constants/app_constants.dart';
import '../../data/models/order_model.dart';

/// Order summary card for checkout page
class OrderSummaryCard extends StatelessWidget {
  final List<OrderItem> items;
  final double subtotal;
  final double shippingCost;
  final double total;

  const OrderSummaryCard({
    Key? key,
    required this.items,
    required this.subtotal,
    required this.shippingCost,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Order Summary',
            style: AppTextStyles.headlineSmall,
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Items
          Column(
            children: List.generate(
              items.length,
              (index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.spacingMd),
                  child: Row(
                    children: [
                      // Product Image
                      if (item.productImage != null)
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppConstants.radiusMd),
                            color: AppColors.accentYellow,
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(AppConstants.radiusMd),
                            child: Image.network(
                              item.productImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.shopping_bag);
                              },
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(AppConstants.radiusMd),
                            color: AppColors.surfaceLight,
                          ),
                          child: const Icon(Icons.shopping_bag),
                        ),
                      const SizedBox(width: AppConstants.spacingMd),

                      // Product Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.productName,
                              style: AppTextStyles.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Quantity: ${item.quantity}',
                              style: AppTextStyles.bodySmallSecondary,
                            ),
                          ],
                        ),
                      ),

                      // Price
                      Text(
                        '\$${item.subtotal.toStringAsFixed(2)}',
                        style: AppTextStyles.titleMedium.copyWith(
                          color: AppColors.neonBlue,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Divider
          Container(
            height: 1,
            color: AppColors.border,
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),

          // Shipping
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Shipping',
                style: AppTextStyles.bodyMedium,
              ),
              Text(
                shippingCost == 0 ? 'FREE' : '\$${shippingCost.toStringAsFixed(2)}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: shippingCost == 0 ? AppColors.neonBlue : AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Divider
          Container(
            height: 1,
            color: AppColors.border,
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: AppTextStyles.headlineSmall,
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: AppTextStyles.price,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

