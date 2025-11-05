import '../../../../core/network/exceptions/api_exception.dart';
import '../../../../core/network/repositories/base_repository.dart';
import '../../../../core/network/services/api_service.dart';
import '../models/product_model.dart';

/// Product Repository for handling product-related API calls
class ProductRepository extends BaseRepository {
  ProductRepository({required ApiService apiService}) : super(apiService: apiService);

  /// Get all products (featured and coming soon)
  Future<Map<String, dynamic>> getAllProducts({Map<String, dynamic>? queryParameters}) async {
    try {
      print('📦 Fetching all products...');

      final response = await executeGet<Map<String, dynamic>>(
        endpoint: '/products',
        queryParameters: queryParameters,
        fromJson: (json) {
          return json as Map<String, dynamic>;
        },
      );

      print('✅ Successfully fetched products');
      return response;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to fetch products: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Get product by ID
  Future<ProductModel> getProductById({required String productId}) async {
    try {
      print('📦 Fetching product: $productId');

      final product = await executeGet<ProductModel>(
        endpoint: '/products/$productId',
        fromJson: (json) {
          return ProductModel.fromJson(json as Map<String, dynamic>);
        },
      );

      print('✅ Successfully fetched product: ${product.name}');
      return product;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to fetch product: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Get featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      print('⭐ Fetching featured products...');

      final products = await executeGet<List<ProductModel>>(
        endpoint: '/products/featured',
        fromJson: (json) {
          if (json is List) {
            return json.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
          }
          throw ParseException(message: 'Expected list of featured products');
        },
      );

      print('✅ Successfully fetched ${products.length} featured products');
      return products;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(
        message: 'Failed to fetch featured products: $e',
        originalException: e,
        stackTrace: stackTrace,
      );
    }
  }

  /// Search products
  Future<List<ProductModel>> searchProducts({required String query, Map<String, dynamic>? filters}) async {
    try {
      print('🔍 Searching products: $query');

      final queryParams = {'q': query, ...?filters};

      final products = await executeGet<List<ProductModel>>(
        endpoint: '/products/search',
        queryParameters: queryParams,
        fromJson: (json) {
          if (json is List) {
            return json.map((item) => ProductModel.fromJson(item as Map<String, dynamic>)).toList();
          }
          throw ParseException(message: 'Expected list of search results');
        },
      );

      print('✅ Found ${products.length} products matching: $query');
      return products;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to search products: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Create product (admin only)
  Future<ProductModel> createProduct({required Map<String, dynamic> productData}) async {
    try {
      print('➕ Creating new product...');

      final product = await executePost<ProductModel>(
        endpoint: '/products',
        body: productData,
        fromJson: (json) {
          return ProductModel.fromJson(json as Map<String, dynamic>);
        },
      );

      print('✅ Successfully created product: ${product.name}');
      return product;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to create product: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Update product (admin only)
  Future<ProductModel> updateProduct({required String productId, required Map<String, dynamic> productData}) async {
    try {
      print('✏️ Updating product: $productId');

      final product = await executePost<ProductModel>(
        endpoint: '/products/$productId',
        body: productData,
        fromJson: (json) {
          return ProductModel.fromJson(json as Map<String, dynamic>);
        },
      );

      print('✅ Successfully updated product: ${product.name}');
      return product;
    } on ApiException catch (e) {
      logError(e, null);
      rethrow;
    } catch (e, stackTrace) {
      logError(e, stackTrace);
      throw UnknownException(message: 'Failed to update product: $e', originalException: e, stackTrace: stackTrace);
    }
  }
}
