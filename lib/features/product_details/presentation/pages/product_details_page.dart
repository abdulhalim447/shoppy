import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/gradient_button.dart';
import '../../data/models/product_details_model.dart';
import '../widgets/features_list.dart';
import '../widgets/product_image_section.dart';
import '../widgets/reviews_section.dart';

/// Product details page
class ProductDetailsPage extends StatefulWidget {
  final ProductDetailsModel product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: MinimalAppBar(title: widget.product.name.toUpperCase()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Section
              ProductImageSection(imageUrl: widget.product.imageUrl, additionalImages: widget.product.additionalImages),
              const SizedBox(height: AppConstants.spacingLg),

              // Product Description
              Text(
                widget.product.fullDescription,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.6),
              ),
              const SizedBox(height: AppConstants.spacingLg),

              // Features List
              FeaturesList(features: widget.product.features),
              const SizedBox(height: AppConstants.spacingLg),

              // Reviews Section
              ReviewsSection(
                rating: widget.product.rating,
                reviewCount: widget.product.reviewCount,
                reviews: widget.product.reviews,
              ),
              const SizedBox(height: AppConstants.spacingXl),

              // Order Now Button
              GradientButton(
                label: 'ORDER NOW',
                onPressed: () {
                  Navigator.of(context).pushNamed(AppConstants.routeShippingAddress);
                },
                width: double.infinity,
                height: 56,
              ),
              const SizedBox(height: AppConstants.spacingMd),
            ],
          ),
        ),
      ),
    );
  }
}
