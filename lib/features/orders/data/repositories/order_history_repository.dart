import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/repositories/base_repository.dart';
import '../../../../core/network/services/api_service.dart';
import '../models/order_history_model.dart';

class OrderHistoryRepository extends BaseRepository {
  OrderHistoryRepository({required ApiService apiService}) : super(apiService: apiService);

  Future<List<OrderHistoryModel>> getOrderHistory({required String guestUsername}) async {
    return await executePost<List<OrderHistoryModel>>(
      endpoint: '/orders/track',
      body: {'guest_username': guestUsername},
      fromJson: (json) {
        if (json is Map<String, dynamic> && json['data'] is List) {
          final dataList = json['data'] as List;
          return dataList.map((item) => OrderHistoryModel.fromJson(item)).toList();
        }
        throw ParseException(message: 'Expected a list of orders in the "data" key');
      },
    );
  }
}
