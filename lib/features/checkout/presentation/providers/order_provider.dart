import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/services/api_service.dart';
import '../../data/models/order_response_model.dart';
import '../../data/repositories/order_repository.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final apiService = ApiService(baseUrl: AppConstants.baseUrl);
  return OrderRepository(apiService: apiService);
});

class OrderState {
  final OrderResponse? orderResponse;
  final bool isLoading;
  final String? error;

  OrderState({this.orderResponse, this.isLoading = false, this.error});

  OrderState copyWith({OrderResponse? orderResponse, bool? isLoading, String? error}) {
    return OrderState(
      orderResponse: orderResponse ?? this.orderResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository _repository;

  OrderNotifier(this._repository) : super(OrderState());

  Future<void> placeOrder({required Map<String, dynamic> orderData}) async {
    try {
      state = state.copyWith(isLoading: true);
      final orderResponse = await _repository.placeOrder(orderData: orderData);
      state = state.copyWith(orderResponse: orderResponse, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(error: _repository.getErrorMessage(e), isLoading: false);
    }
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrderNotifier(repository);
});
