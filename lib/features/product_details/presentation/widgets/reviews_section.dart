import 'package:flutter/material.dart';
import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/text_styles.dart';
import '../../../../config/constants/app_constants.dart';
import '../../data/models/product_details_model.dart';

/// Reviews section widget for product details
class ReviewsSection extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final List<CustomerReview> reviews;

  const ReviewsSection({
    Key? key,
    required this.rating,
    required this.reviewCount,
    required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Customer Reviews',
          style: AppTextStyles.headlineSmall,
        ),
        const SizedBox(height: AppConstants.spacingMd),

        // Overall Rating
        Row(
          children: [
            // Stars
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating.toInt() ? Icons.star : Icons.star_border,
                  color: AppColors.neonBlue,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: AppConstants.spacingSm),

            // Rating Text
            Text(
              '$rating out of 5 ($reviewCount reviews)',
              style: AppTextStyles.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: AppConstants.spacingLg),

        // Individual Reviews
        if (reviews.isNotEmpty)
          Column(
            children: List.generate(
              reviews.length,
              (index) => _ReviewCard(review: reviews[index]),
            ),
          )
        else
          Center(
            child: Text(
              'No reviews yet',
              style: AppTextStyles.bodyMediumSecondary,
            ),
          ),
      ],
    );
  }
}

/// Individual review card
class _ReviewCard extends StatelessWidget {
  final CustomerReview review;

  const _ReviewCard({
    Key? key,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.spacingMd),
      margin: const EdgeInsets.only(bottom: AppConstants.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Review Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Stars
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < review.rating.toInt() ? Icons.star : Icons.star_border,
                    color: AppColors.neonBlue,
                    size: 16,
                  ),
                ),
              ),
              // Verified Badge
              if (review.isVerifiedPurchase)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.neonBlue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Verified',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.neonBlue,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingSm),

          // Review Title
          Text(
            review.title,
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppConstants.spacingSm),

          // Review Content
          Text(
            review.content,
            style: AppTextStyles.bodySmallSecondary,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppConstants.spacingSm),

          // Reviewer Name and Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                review.reviewerName,
                style: AppTextStyles.labelSmall,
              ),
              Text(
                review.reviewDate.toString().split(' ')[0],
                style: AppTextStyles.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

