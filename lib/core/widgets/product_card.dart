import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/text_styles.dart';
import 'badge.dart';

/// Product card widget for displaying products in grid/list
class ProductCard extends StatefulWidget {
  final String productName;
  final String? productImage;
  final double price;
  final String? badgeLabel;
  final BadgeType? badgeType;
  final VoidCallback? onTap;
  final double? width;
  final double height;
  final bool showPrice;

  const ProductCard({
    Key? key,
    required this.productName,
    this.productImage,
    required this.price,
    this.badgeLabel,
    this.badgeType,
    this.onTap,
    this.width,
    this.height = 280,
    this.showPrice = true,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image Section
              Expanded(
                child: Stack(
                  children: [
                    // Image
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        color: AppColors.surfaceLight,
                      ),
                      child: widget.productImage != null
                          ? Image.network(
                              widget.productImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                  child: Icon(Icons.image_not_supported, color: AppColors.textSecondary, size: 48),
                                );
                              },
                            )
                          : Center(child: Icon(Icons.shopping_bag, color: AppColors.textSecondary, size: 48)),
                    ),
                    // Badge
                    if (widget.badgeLabel != null && widget.badgeType != null)
                      Positioned(
                        top: 12,
                        left: 12,
                        child: CustomBadge(label: widget.badgeLabel!, type: widget.badgeType!),
                      ),
                  ],
                ),
              ),
              // Product Info Section
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      widget.productName,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    // Price
                    if (widget.showPrice)
                      Text('\$${widget.price.toStringAsFixed(2)}', style: AppTextStyles.price.copyWith(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Horizontal product card for carousel
class HorizontalProductCard extends StatelessWidget {
  final String productName;
  final String? productImage;
  final double price;
  final String? badgeLabel;
  final BadgeType? badgeType;
  final VoidCallback? onTap;

  const HorizontalProductCard({
    Key? key,
    required this.productName,
    this.productImage,
    required this.price,
    this.badgeLabel,
    this.badgeType,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      color: AppColors.surfaceLight,
                    ),
                    child: productImage != null
                        ? Image.network(
                            productImage!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(Icons.image_not_supported, color: AppColors.textSecondary, size: 32),
                              );
                            },
                          )
                        : Center(child: Icon(Icons.shopping_bag, color: AppColors.textSecondary, size: 32)),
                  ),
                  // Badge
                  if (badgeLabel != null && badgeType != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: CustomBadge(
                        label: badgeLabel!,
                        type: badgeType!,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      ),
                    ),
                ],
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.titleSmall),
                  const SizedBox(height: 4),
                  Text('\$${price.toStringAsFixed(2)}', style: AppTextStyles.price.copyWith(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
