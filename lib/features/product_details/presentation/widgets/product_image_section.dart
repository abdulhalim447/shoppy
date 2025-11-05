import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/constants/app_constants.dart';

/// Product image section for product details page
class ProductImageSection extends StatefulWidget {
  final String? imageUrl;
  final List<String>? additionalImages;

  const ProductImageSection({
    Key? key,
    this.imageUrl,
    this.additionalImages,
  }) : super(key: key);

  @override
  State<ProductImageSection> createState() => _ProductImageSectionState();
}

class _ProductImageSectionState extends State<ProductImageSection> {
  late PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<String> get _allImages {
    final images = <String>[];
    if (widget.imageUrl != null) {
      images.add(widget.imageUrl!);
    }
    if (widget.additionalImages != null) {
      images.addAll(widget.additionalImages!);
    }
    return images.isNotEmpty ? images : [''];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main Image
        Container(
          width: double.infinity,
          height: 300,
          decoration: BoxDecoration(
            color: AppColors.accentYellow,
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          ),
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: _allImages.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.radiusLg),
                child: _allImages[index].isEmpty
                    ? Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: AppColors.textSecondary,
                          size: 64,
                        ),
                      )
                    : Image.network(
                        _allImages[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.textSecondary,
                              size: 64,
                            ),
                          );
                        },
                      ),
              );
            },
          ),
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Image Indicators
        if (_allImages.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _allImages.length,
              (index) => Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentImageIndex
                      ? AppColors.neonBlue
                      : AppColors.border,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

