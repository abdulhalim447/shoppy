import '../../../../core/network/repositories/base_repository.dart';
import '../../../../core/network/services/api_service.dart';
import '../models/order_response_model.dart';

class OrderRepository extends BaseRepository {
  OrderRepository({required ApiService apiService}) : super(apiService: apiService);

  Future<OrderResponse> placeOrder({required Map<String, dynamic> orderData}) async {
    return await executePost<OrderResponse>(
      endpoint: '/orders',
      body: orderData,
      fromJson: (json) => OrderResponse.fromJson(json['data']),
    );
  }
}
