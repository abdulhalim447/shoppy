/// Customer review model
class CustomerReview {
  final String reviewerName;
  final double rating;
  final String title;
  final String content;
  final DateTime reviewDate;
  final bool isVerifiedPurchase;

  CustomerReview({
    required this.reviewerName,
    required this.rating,
    required this.title,
    required this.content,
    required this.reviewDate,
    this.isVerifiedPurchase = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'reviewerName': reviewerName,
      'rating': rating,
      'title': title,
      'content': content,
      'reviewDate': reviewDate.toIso8601String(),
      'isVerifiedPurchase': isVerifiedPurchase,
    };
  }

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      reviewerName: json['reviewerName'] as String,
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String,
      content: json['content'] as String,
      reviewDate: DateTime.parse(json['reviewDate'] as String),
      isVerifiedPurchase: json['isVerifiedPurchase'] as bool? ?? true,
    );
  }
}

/// Product details model with extended information
class ProductDetailsModel {
  final String id;
  final String name;
  final String description;
  final String fullDescription;
  final double price;
  final String? imageUrl;
  final List<String>? additionalImages;
  final bool isExclusive;
  final bool isComingSoon;
  final double rating;
  final int reviewCount;
  final List<String> features;
  final List<CustomerReview> reviews;
  final int stockCount;
  final String sku;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.price,
    this.imageUrl,
    this.additionalImages,
    this.isExclusive = false,
    this.isComingSoon = false,
    required this.rating,
    required this.reviewCount,
    required this.features,
    required this.reviews,
    required this.stockCount,
    required this.sku,
  });

  /// Check if product is in stock
  bool get isInStock => stockCount > 0;

  /// Get average rating as string
  String get ratingString => '$rating out of 5';

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'fullDescription': fullDescription,
      'price': price,
      'imageUrl': imageUrl,
      'additionalImages': additionalImages,
      'isExclusive': isExclusive,
      'isComingSoon': isComingSoon,
      'rating': rating,
      'reviewCount': reviewCount,
      'features': features,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'stockCount': stockCount,
      'sku': sku,
    };
  }

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      fullDescription: json['fullDescription'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      additionalImages: List<String>.from(json['additionalImages'] as List? ?? []),
      isExclusive: json['isExclusive'] as bool? ?? false,
      isComingSoon: json['isComingSoon'] as bool? ?? false,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      features: List<String>.from(json['features'] as List? ?? []),
      reviews: (json['reviews'] as List?)
              ?.map((e) => CustomerReview.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      stockCount: json['stockCount'] as int,
      sku: json['sku'] as String,
    );
  }
}

