import 'package:flutter/material.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../core/widgets/badge.dart';
import '../../../../core/widgets/product_card.dart';
import '../../data/models/product_model.dart';

/// Upcoming products carousel section for home page
class UpcomingProductsCarousel extends StatefulWidget {
  final List<ProductModel> products;
  final VoidCallback? onProductTap;

  const UpcomingProductsCarousel({Key? key, required this.products, this.onProductTap}) : super(key: key);

  @override
  State<UpcomingProductsCarousel> createState() => _UpcomingProductsCarouselState();
}

class _UpcomingProductsCarouselState extends State<UpcomingProductsCarousel> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text('Upcoming Products', style: AppTextStyles.headlineLarge),
        const SizedBox(height: AppConstants.spacingMd),

        // Products Carousel
        SizedBox(
          height: 280,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              final product = widget.products[index];
              return HorizontalProductCard(
                productName: product.name,
                productImage: product.image,
                price: double.tryParse(product.price) ?? 0.0,
                badgeLabel: product.badge ?? AppConstants.comingSoonBadgeText,
                badgeType: product.available ? BadgeType.exclusive : BadgeType.comingSoon,
                onTap: widget.onProductTap,
              );
            },
          ),
        ),
      ],
    );
  }
}
