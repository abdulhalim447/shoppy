import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_constants.dart';
import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/services/api_service.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/data/repositories/product_repository.dart';

/// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: AppConstants.baseUrl, timeout: const Duration(seconds: 30));
});

/// Product Repository Provider
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return ProductRepository(apiService: apiService);
});

/// Product State
class ProductState {
  final ProductModel? mainProduct;
  final List<ProductModel> comingSoonProducts;
  final bool isLoading;
  final String? error;
  final bool hasError;

  ProductState({
    this.mainProduct,
    this.comingSoonProducts = const [],
    this.isLoading = false,
    this.error,
    this.hasError = false,
  });

  ProductState copyWith({
    ProductModel? mainProduct,
    List<ProductModel>? comingSoonProducts,
    bool? isLoading,
    String? error,
    bool? hasError,
  }) {
    return ProductState(
      mainProduct: mainProduct ?? this.mainProduct,
      comingSoonProducts: comingSoonProducts ?? this.comingSoonProducts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasError: hasError ?? this.hasError,
    );
  }
}

/// Product Notifier
class ProductNotifier extends StateNotifier<ProductState> {
  final ProductRepository _repository;

  ProductNotifier(this._repository) : super(ProductState());

  /// Fetch all products
  Future<void> fetchAllProducts() async {
    try {
      state = state.copyWith(isLoading: true, hasError: false, error: null);

      final response = await _repository.getAllProducts();

      // Parse response
      final data = response['data'] as Map<String, dynamic>?;
      final mainProductData = data?['main_product'] as Map<String, dynamic>?;
      final comingSoonData = data?['coming_soon'] as List?;

      final mainProduct = mainProductData != null ? ProductModel.fromJson(mainProductData) : null;

      final comingSoonProducts = comingSoonData != null
          ? comingSoonData.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList()
          : <ProductModel>[];

      state = state.copyWith(
        mainProduct: mainProduct,
        comingSoonProducts: comingSoonProducts,
        isLoading: false,
        hasError: false,
      );

      print('✅ Products loaded successfully');
    } on ApiException catch (e) {
      final errorMessage = _repository.getErrorMessage(e);
      state = state.copyWith(isLoading: false, hasError: true, error: errorMessage);
      print('❌ Error fetching products: $errorMessage');
    } catch (e) {
      state = state.copyWith(isLoading: false, hasError: true, error: 'একটি অপ্রত্যাশিত ত্রুটি ঘটেছে');
      print('❌ Unexpected error: $e');
    }
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(hasError: false, error: null);
  }

  /// Reset state
  void reset() {
    state = ProductState();
  }
}

/// Product Provider
final productProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return ProductNotifier(repository);
});

/// Get single product provider
final singleProductProvider = FutureProvider.family<ProductModel, String>((ref, productId) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(productId: productId);
});
