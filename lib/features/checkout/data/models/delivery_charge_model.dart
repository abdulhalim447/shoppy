class DeliveryCharge {
  final String locationType;
  final String locationName;
  final int charge;
  final String formattedCharge;
  final String description;

  DeliveryCharge({
    required this.locationType,
    required this.locationName,
    required this.charge,
    required this.formattedCharge,
    required this.description,
  });

  factory DeliveryCharge.fromJson(Map<String, dynamic> json) {
    return DeliveryCharge(
      locationType: json['location_type'],
      locationName: json['location_name'],
      charge: json['charge'],
      formattedCharge: json['formatted_charge'],
      description: json['description'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryCharge && runtimeType == other.runtimeType && locationType == other.locationType;

  @override
  int get hashCode => locationType.hashCode;
}
