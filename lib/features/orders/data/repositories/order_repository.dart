import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/repositories/base_repository.dart';
import '../../../../core/network/services/api_service.dart';
import '../models/order_model.dart';

/// Order Repository for handling order-related API calls
class OrderRepository extends BaseRepository {
  OrderRepository({required ApiService apiService}) : super(apiService: apiService);

  /// Get all orders for current user
  Future<List<OrderModel>> getAllOrders({Map<String, dynamic>? queryParameters}) async {
    try {
      print('📦 Fetching all orders...');

      final orders = await executeGet<List<OrderModel>>(
        endpoint: '/orders',
        queryParameters: queryParameters,
        fromJson: (json) {
          if (json is List) {
            return json.map((item) => OrderModel.fromJson(item as Map<String, dynamic>)).toList();
          }
          throw ParseException(message: 'Expected list of orders');
        },
      );

      print('✅ Successfully fetched ${orders.length} orders');
      return orders;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to fetch orders: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Get order by ID
  Future<OrderModel> getOrderById({required String orderId}) async {
    try {
      print('📦 Fetching order: $orderId');

      final order = await executeGet<OrderModel>(
        endpoint: '/orders/$orderId',
        fromJson: (json) {
          return OrderModel.fromJson(json as Map<String, dynamic>);
        },
      );

      print('✅ Successfully fetched order: ${order.id}');
      return order;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to fetch order: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Create new order
  Future<OrderModel> createOrder({required Map<String, dynamic> orderData}) async {
    try {
      print('➕ Creating new order...');

      final order = await executePost<OrderModel>(
        endpoint: '/orders',
        body: orderData,
        fromJson: (json) {
          return OrderModel.fromJson(json as Map<String, dynamic>);
        },
      );

      print('✅ Successfully created order: ${order.id}');
      return order;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to create order: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Update order status
  Future<OrderModel> updateOrderStatus({required String orderId, required String status}) async {
    try {
      print('✏️ Updating order status: $orderId -> $status');

      final order = await executePost<OrderModel>(
        endpoint: '/orders/$orderId/status',
        body: {'status': status},
        fromJson: (json) {
          return OrderModel.fromJson(json as Map<String, dynamic>);
        },
      );

      print('✅ Successfully updated order status');
      return order;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(
        message: 'Failed to update order status: $e',
        originalException: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Cancel order
  Future<OrderModel> cancelOrder({required String orderId, String? reason}) async {
    try {
      print('❌ Cancelling order: $orderId');

      final order = await executePost<OrderModel>(
        endpoint: '/orders/$orderId/cancel',
        body: {'reason': reason},
        fromJson: (json) {
          return OrderModel.fromJson(json as Map<String, dynamic>);
        },
      );

      print('✅ Successfully cancelled order');
      return order;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to cancel order: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Get order tracking information
  Future<Map<String, dynamic>> getOrderTracking({required String orderId}) async {
    try {
      print('🚚 Fetching order tracking: $orderId');

      final tracking = await executeGet<Map<String, dynamic>>(
        endpoint: '/orders/$orderId/tracking',
        fromJson: (json) {
          return json as Map<String, dynamic>;
        },
      );

      print('✅ Successfully fetched tracking information');
      return tracking;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(
        message: 'Failed to fetch tracking information: $e',
        originalException: e,
        stackTrace: stackTrace,
      );
    }
  }
}
