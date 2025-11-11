import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/services/api_service.dart';
import '../../../../core/network/services/api_service.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../data/models/order_history_model.dart';
import '../../data/repositories/order_history_repository.dart';

final orderHistoryRepositoryProvider = Provider<OrderHistoryRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrderHistoryRepository(apiService: apiService);
});

class OrderHistoryState {
  final List<OrderHistoryModel> orders;
  final bool isLoading;
  final String? error;

  OrderHistoryState({this.orders = const [], this.isLoading = false, this.error});

  OrderHistoryState copyWith({List<OrderHistoryModel>? orders, bool? isLoading, String? error}) {
    return OrderHistoryState(
      orders: orders ?? this.orders,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class OrderHistoryNotifier extends StateNotifier<OrderHistoryState> {
  final OrderHistoryRepository _repository;
  final LocalStorageService _localStorageService;

  OrderHistoryNotifier(this._repository, this._localStorageService) : super(OrderHistoryState());

  Future<void> fetchOrderHistory() async {
    try {
      state = state.copyWith(isLoading: true);
      final guestUsername = await _localStorageService.getGuestUsername();
      if (guestUsername != null) {
        final orders = await _repository.getOrderHistory(guestUsername: guestUsername);
        state = state.copyWith(orders: orders, isLoading: false);
      } else {
        state = state.copyWith(error: 'Guest username not found', isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}

final orderHistoryProvider = StateNotifierProvider<OrderHistoryNotifier, OrderHistoryState>((ref) {
  final repository = ref.watch(orderHistoryRepositoryProvider);
  final localStorageService = LocalStorageService();
  return OrderHistoryNotifier(repository, localStorageService);
});
