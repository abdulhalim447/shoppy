/// Order model for API responses
class OrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final String productName;
  final String productImage;
  final double price;
  final String formattedPrice;
  final int quantity;
  final String shippingAddress;
  final String estimatedDelivery;
  final DateTime createdAt;
  final DateTime? updatedAt;

  OrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.productName,
    required this.productImage,
    required this.price,
    required this.formattedPrice,
    required this.quantity,
    required this.shippingAddress,
    required this.estimatedDelivery,
    required this.createdAt,
    this.updatedAt,
  });

  /// Create OrderModel from JSON
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: (json['id'] ?? '').toString(),
      orderNumber: json['order_number'] as String? ?? '',
      status: json['status'] as String? ?? 'pending',
      productName: json['product_name'] as String? ?? '',
      productImage: json['product_image'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      formattedPrice: json['formatted_price'] as String? ?? '\$0.00',
      quantity: json['quantity'] as int? ?? 1,
      shippingAddress: json['shipping_address'] as String? ?? '',
      estimatedDelivery: json['estimated_delivery'] as String? ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Convert OrderModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_number': orderNumber,
      'status': status,
      'product_name': productName,
      'product_image': productImage,
      'price': price,
      'formatted_price': formattedPrice,
      'quantity': quantity,
      'shipping_address': shippingAddress,
      'estimated_delivery': estimatedDelivery,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  /// Copy with method
  OrderModel copyWith({
    String? id,
    String? orderNumber,
    String? status,
    String? productName,
    String? productImage,
    double? price,
    String? formattedPrice,
    int? quantity,
    String? shippingAddress,
    String? estimatedDelivery,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderModel(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      productName: productName ?? this.productName,
      productImage: productImage ?? this.productImage,
      price: price ?? this.price,
      formattedPrice: formattedPrice ?? this.formattedPrice,
      quantity: quantity ?? this.quantity,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      estimatedDelivery: estimatedDelivery ?? this.estimatedDelivery,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, orderNumber: $orderNumber, status: $status, productName: $productName, price: $price)';
  }
}

