import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../core/widgets/shimmer_placeholder.dart';
import '../../../home/data/models/product_model.dart';

/// Product order summary widget for checkout
class ProductOrderSummary extends StatefulWidget {
  final ProductModel product;
  final int initialQuantity;
  final Function(int)? onQuantityChanged;

  const ProductOrderSummary({Key? key, required this.product, this.initialQuantity = 1, this.onQuantityChanged})
    : super(key: key);

  @override
  State<ProductOrderSummary> createState() => _ProductOrderSummaryState();
}

class _ProductOrderSummaryState extends State<ProductOrderSummary> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      widget.onQuantityChanged?.call(_quantity);
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        widget.onQuantityChanged?.call(_quantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Parse price
    final price = double.tryParse(widget.product.price) ?? 0.0;
    final subtotal = price * _quantity;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text('ORDER SUMMARY', style: AppTextStyles.labelLarge),
          const SizedBox(height: AppConstants.spacingMd),

          // Product Card
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(color: AppColors.border, width: 1),
            ),
            padding: const EdgeInsets.all(AppConstants.spacingMd),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                    color: AppColors.surfaceLight,
                  ),
                  child: widget.product.image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.image!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => ShimmerPlaceholder(
                              width: 100,
                              height: 100,
                              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                            ),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.image_not_supported, color: AppColors.textSecondary, size: 32),
                            ),
                          ),
                        )
                      : Center(child: Icon(Icons.shopping_bag, color: AppColors.textSecondary, size: 32)),
                ),
                const SizedBox(width: AppConstants.spacingMd),

                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Name
                      Text(
                        widget.product.name,
                        style: AppTextStyles.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppConstants.spacingSm),

                      // Stock Status
                      if (widget.product.stockStatus != null)
                        Text(widget.product.stockStatus!, style: AppTextStyles.bodySmallSecondary),
                      const SizedBox(height: AppConstants.spacingMd),

                      // Price
                      Text(widget.product.formattedPrice ?? widget.product.price, style: AppTextStyles.price),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Quantity with +/- buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Quantity', style: AppTextStyles.bodyMedium),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppConstants.radiusSm),
                  border: Border.all(color: AppColors.border, width: 1),
                ),
                child: Row(
                  children: [
                    // Minus Button
                    IconButton(
                      onPressed: _decrementQuantity,
                      icon: const Icon(Icons.remove, size: 18),
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      padding: EdgeInsets.zero,
                    ),
                    // Quantity Display
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text('$_quantity', style: AppTextStyles.bodyMedium, textAlign: TextAlign.center),
                    ),
                    // Plus Button
                    IconButton(
                      onPressed: _incrementQuantity,
                      icon: const Icon(Icons.add, size: 18),
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),

          // Divider
          Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: AppConstants.spacingMd),

          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subtotal', style: AppTextStyles.bodyMedium),
              Text('৳${subtotal.toStringAsFixed(2)}', style: AppTextStyles.bodyMedium),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),

          // Shipping
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Shipping', style: AppTextStyles.bodyMedium),
              Text('FREE', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.success)),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMd),

          // Divider
          Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: AppConstants.spacingMd),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTextStyles.headlineSmall),
              Text(
                '৳${subtotal.toStringAsFixed(2)}',
                style: AppTextStyles.headlineSmall.copyWith(color: AppColors.neonBlue),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
