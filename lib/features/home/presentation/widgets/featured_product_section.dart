import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../core/widgets/badge.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../../../core/widgets/shimmer_placeholder.dart';
import '../../data/models/product_model.dart';

/// Featured product section for home page
class FeaturedProductSection extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onBuyNow;

  const FeaturedProductSection({Key? key, required this.product, required this.onBuyNow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image with Badge
        Stack(
          children: [
            // Image Container
            Container(
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                color: AppColors.accentYellow,
              ),
              child: product.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                      child: CachedNetworkImage(
                        imageUrl: product.image!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => ShimmerPlaceholder(
                          width: double.infinity,
                          height: 320,
                          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                        ),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.image_not_supported, color: AppColors.textSecondary, size: 64)),
                      ),
                    )
                  : Center(child: Icon(Icons.shopping_bag, color: AppColors.textSecondary, size: 64)),
            ),
            // Badge
            if (product.badge != null && product.badge!.isNotEmpty)
              Positioned(
                top: 16,
                left: 16,
                child: CustomBadge(
                  label: product.badge!,
                  type: product.available ? BadgeType.exclusive : BadgeType.comingSoon,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingLg),

        // Product Name
        Text(product.name, style: AppTextStyles.displaySmall),
        const SizedBox(height: AppConstants.spacingSm),

        // Product Description
        if (product.description != null && product.description!.isNotEmpty)
          Text(
            product.description!,
            style: AppTextStyles.bodyMediumSecondary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        const SizedBox(height: AppConstants.spacingMd),

        // Price
        Text(product.formattedPrice ?? product.price, style: AppTextStyles.price),
        const SizedBox(height: AppConstants.spacingLg),

        // Buy Now Button
        GradientButton(label: 'BUY NOW', onPressed: onBuyNow, width: double.infinity, height: 56),
      ],
    );
  }
}
