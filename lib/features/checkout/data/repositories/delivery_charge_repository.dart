import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/repositories/base_repository.dart';
import '../../../../core/network/services/api_service.dart';
import '../models/delivery_charge_model.dart';

class DeliveryChargeRepository extends BaseRepository {
  DeliveryChargeRepository({required ApiService apiService}) : super(apiService: apiService);

  Future<List<DeliveryCharge>> getDeliveryCharges() async {
    return await executeGet<List<DeliveryCharge>>(
      endpoint: '/charges',
      fromJson: (json) {
        if (json is Map<String, dynamic> && json.containsKey('data') && json['data'] is List) {
          final data = json['data'] as List;
          return data.map((item) => DeliveryCharge.fromJson(item)).toList();
        }
        throw ParseException(message: 'Expected a map with a list of delivery charges');
      },
    );
  }
}
