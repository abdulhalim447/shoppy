class OrderResponse {
  final String guestUsername;
  final int orderId;
  final Order order;

  OrderResponse({required this.guestUsername, required this.orderId, required this.order});

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      guestUsername: json['guest_username'],
      orderId: json['order_id'],
      order: Order.fromJson(json['order']),
    );
  }
}

class Order {
  final int id;
  final String guestUsername;
  final Product product;
  final Customer customer;
  final DeliveryAddress deliveryAddress;
  final Pricing pricing;
  final String status;
  final String createdAt;

  Order({
    required this.id,
    required this.guestUsername,
    required this.product,
    required this.customer,
    required this.deliveryAddress,
    required this.pricing,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      guestUsername: json['guest_username'],
      product: Product.fromJson(json['product']),
      customer: Customer.fromJson(json['customer']),
      deliveryAddress: DeliveryAddress.fromJson(json['delivery_address']),
      pricing: Pricing.fromJson(json['pricing']),
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String image;

  Product({required this.id, required this.name, required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(id: json['id'], name: json['name'], image: json['image']);
  }
}

class Customer {
  final String fullName;
  final String phoneNumber;

  Customer({required this.fullName, required this.phoneNumber});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(fullName: json['full_name'], phoneNumber: json['phone_number']);
  }
}

class DeliveryAddress {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String? zipCode;
  final String country;
  final String deliveryPlace;
  final String deliveryPlaceText;

  DeliveryAddress({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    this.zipCode,
    required this.country,
    required this.deliveryPlace,
    required this.deliveryPlaceText,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      addressLine1: json['address_line1'],
      addressLine2: json['address_line2'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zip_code'],
      country: json['country'],
      deliveryPlace: json['delivery_place'],
      deliveryPlaceText: json['delivery_place_text'],
    );
  }
}

class Pricing {
  final int quantity;
  final String unitPrice;
  final String subtotal;
  final String deliveryCharge;
  final String totalAmount;
  final String currency;

  Pricing({
    required this.quantity,
    required this.unitPrice,
    required this.subtotal,
    required this.deliveryCharge,
    required this.totalAmount,
    required this.currency,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) {
    return Pricing(
      quantity: json['quantity'],
      unitPrice: json['unit_price'],
      subtotal: json['subtotal'],
      deliveryCharge: json['delivery_charge'],
      totalAmount: json['total_amount'],
      currency: json['currency'],
    );
  }
}
