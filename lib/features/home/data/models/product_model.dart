/// Product model for home and product listing
class ProductModel {
  final String id;
  final String name;
  final String? description;
  final String price; // Keep as string to match API
  final String? image;
  final String? formattedPrice;
  final String? badge;
  final bool available;
  final String? stockStatus;
  final double? rating;
  final int? reviewCount;
  final List<String>? features;

  ProductModel({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.image,
    this.formattedPrice,
    this.badge,
    this.available = true,
    this.stockStatus,
    this.rating,
    this.reviewCount,
    this.features,
  });

  /// Create a copy of this model with some fields replaced
  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? price,
    String? image,
    String? formattedPrice,
    String? badge,
    bool? available,
    String? stockStatus,
    double? rating,
    int? reviewCount,
    List<String>? features,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      formattedPrice: formattedPrice ?? this.formattedPrice,
      badge: badge ?? this.badge,
      available: available ?? this.available,
      stockStatus: stockStatus ?? this.stockStatus,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      features: features ?? this.features,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'formatted_price': formattedPrice,
      'badge': badge,
      'available': available,
      'stock_status': stockStatus,
      'rating': rating,
      'reviewCount': reviewCount,
      'features': features,
    };
  }

  /// Create from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] ?? '').toString(),
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      price: (json['price'] ?? '0').toString(),
      image: json['image'] as String?,
      formattedPrice: json['formatted_price'] as String?,
      badge: json['badge'] as String?,
      available: json['available'] as bool? ?? true,
      stockStatus: json['stock_status'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      features: List<String>.from(json['features'] as List? ?? []),
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, price: $price, available: $available, badge: $badge)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          price == other.price;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;
}
