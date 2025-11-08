import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/services/api_service.dart';
import '../../data/models/delivery_charge_model.dart';
import '../../data/repositories/delivery_charge_repository.dart';

final deliveryChargeRepositoryProvider = Provider<DeliveryChargeRepository>((ref) {
  final apiService = ApiService(baseUrl: AppConstants.baseUrl);
  return DeliveryChargeRepository(apiService: apiService);
});

class DeliveryChargeState {
  final List<DeliveryCharge> deliveryCharges;
  final bool isLoading;
  final String? error;

  DeliveryChargeState({this.deliveryCharges = const [], this.isLoading = false, this.error});

  DeliveryChargeState copyWith({List<DeliveryCharge>? deliveryCharges, bool? isLoading, String? error}) {
    return DeliveryChargeState(
      deliveryCharges: deliveryCharges ?? this.deliveryCharges,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class DeliveryChargeNotifier extends StateNotifier<DeliveryChargeState> {
  final DeliveryChargeRepository _repository;

  DeliveryChargeNotifier(this._repository) : super(DeliveryChargeState());

  Future<void> fetchDeliveryCharges() async {
    try {
      state = state.copyWith(isLoading: true);
      final deliveryCharges = await _repository.getDeliveryCharges();
      state = state.copyWith(deliveryCharges: deliveryCharges, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(error: _repository.getErrorMessage(e), isLoading: false);
    }
  }
}

final deliveryChargeProvider = StateNotifierProvider<DeliveryChargeNotifier, DeliveryChargeState>((ref) {
  final repository = ref.watch(deliveryChargeRepositoryProvider);
  return DeliveryChargeNotifier(repository);
});
