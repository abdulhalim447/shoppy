/// Order status enum
enum OrderStatus {
  placed,
  processing,
  outForDelivery,
  delivered,
  cancelled,
}

/// Shipping address model
class ShippingAddress {
  final String fullName;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String phoneNumber;

  ShippingAddress({
    required this.fullName,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'phoneNumber': phoneNumber,
    };
  }

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      fullName: json['fullName'] as String,
      addressLine1: json['addressLine1'] as String,
      addressLine2: json['addressLine2'] as String?,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }
}

/// Order item model
class OrderItem {
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  final String? productImage;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    this.productImage,
  });

  double get subtotal => price * quantity;

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'productImage': productImage,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      productImage: json['productImage'] as String?,
    );
  }
}

/// Order model
class OrderModel {
  final String orderId;
  final List<OrderItem> items;
  final ShippingAddress shippingAddress;
  final double subtotal;
  final double shippingCost;
  final double total;
  final OrderStatus status;
  final DateTime orderDate;
  final DateTime? estimatedDeliveryDate;
  final List<OrderTimeline>? timeline;

  OrderModel({
    required this.orderId,
    required this.items,
    required this.shippingAddress,
    required this.subtotal,
    required this.shippingCost,
    required this.total,
    required this.status,
    required this.orderDate,
    this.estimatedDeliveryDate,
    this.timeline,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'items': items.map((e) => e.toJson()).toList(),
      'shippingAddress': shippingAddress.toJson(),
      'subtotal': subtotal,
      'shippingCost': shippingCost,
      'total': total,
      'status': status.toString(),
      'orderDate': orderDate.toIso8601String(),
      'estimatedDeliveryDate': estimatedDeliveryDate?.toIso8601String(),
      'timeline': timeline?.map((e) => e.toJson()).toList(),
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as String,
      items: (json['items'] as List)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      shippingAddress:
          ShippingAddress.fromJson(json['shippingAddress'] as Map<String, dynamic>),
      subtotal: (json['subtotal'] as num).toDouble(),
      shippingCost: (json['shippingCost'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => OrderStatus.placed,
      ),
      orderDate: DateTime.parse(json['orderDate'] as String),
      estimatedDeliveryDate: json['estimatedDeliveryDate'] != null
          ? DateTime.parse(json['estimatedDeliveryDate'] as String)
          : null,
      timeline: (json['timeline'] as List?)
          ?.map((e) => OrderTimeline.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Order timeline event
class OrderTimeline {
  final OrderStatus status;
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isCompleted;

  OrderTimeline({
    required this.status,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'status': status.toString(),
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory OrderTimeline.fromJson(Map<String, dynamic> json) {
    return OrderTimeline(
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == json['status'],
        orElse: () => OrderStatus.placed,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isCompleted: json['isCompleted'] as bool,
    );
  }
}

