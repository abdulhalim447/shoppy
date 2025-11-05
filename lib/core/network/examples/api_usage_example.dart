/// API Usage Examples
/// 
/// এই ফাইলটি দেখায় কীভাবে API integration ব্যবহার করতে হয়।
/// এটি একটি reference guide এবং production code এ ব্যবহার করা যায় না।

// ============================================================================
// EXAMPLE 1: Simple GET Request
// ============================================================================

/*
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../../features/home/data/models/product_model.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: 'https://api.shoppy.com');
});

// Simple GET example
Future<void> fetchProductsExample(WidgetRef ref) async {
  final apiService = ref.read(apiServiceProvider);
  
  try {
    final response = await apiService.get<List<ProductModel>>(
      endpoint: '/products',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) => ProductModel.fromJson(item))
              .toList();
        }
        throw Exception('Invalid response');
      },
    );

    if (response.isSuccess) {
      print('✅ Products: ${response.data}');
    } else {
      print('❌ Error: ${response.message}');
    }
  } on TimeoutException catch (e) {
    print('⏱️ Timeout: ${e.message}');
  } on NetworkException catch (e) {
    print('🌐 Network Error: ${e.message}');
  } on ApiException catch (e) {
    print('❌ API Error: ${e.message}');
  }
}
*/

// ============================================================================
// EXAMPLE 2: POST Request with Error Handling
// ============================================================================

/*
Future<void> createProductExample(WidgetRef ref) async {
  final apiService = ref.read(apiServiceProvider);
  
  try {
    final response = await apiService.post<ProductModel>(
      endpoint: '/products',
      body: {
        'name': 'New Product',
        'price': 199.99,
        'description': 'Product description',
      },
      fromJson: (json) => ProductModel.fromJson(json),
    );

    if (response.isSuccess) {
      print('✅ Product created: ${response.data?.name}');
    } else {
      print('❌ Error: ${response.message}');
    }
  } on UnauthorizedException catch (e) {
    print('🔐 Unauthorized: ${e.message}');
    // Redirect to login
  } on ClientException catch (e) {
    print('❌ Client Error: ${e.message}');
  } on ServerException catch (e) {
    print('🔴 Server Error: ${e.message}');
  }
}
*/

// ============================================================================
// EXAMPLE 3: Using Repository Pattern
// ============================================================================

/*
import '../../features/home/data/repositories/product_repository.dart';

Future<void> repositoryExample(WidgetRef ref) async {
  final repository = ref.read(productRepositoryProvider);
  
  try {
    // GET example
    final products = await repository.getAllProducts();
    print('✅ Fetched ${products.length} products');

    // POST example
    final newProduct = await repository.createProduct(
      productData: {
        'name': 'New Product',
        'price': 199.99,
      },
    );
    print('✅ Created product: ${newProduct.name}');

  } on UnauthorizedException catch (e) {
    print('🔐 Session expired: ${e.message}');
  } on NotFoundException catch (e) {
    print('❌ Not found: ${e.message}');
  } on TimeoutException catch (e) {
    print('⏱️ Request timeout: ${e.message}');
  } on ApiException catch (e) {
    print('❌ API Error: ${e.message}');
  }
}
*/

// ============================================================================
// EXAMPLE 4: Using Provider for State Management
// ============================================================================

/*
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/presentation/providers/product_provider.dart';

class ProductListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    // Load products on first build
    ref.listen(productProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error ?? 'Error')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: productState.isLoading
          ? Center(child: CircularProgressIndicator())
          : productState.hasError
              ? Center(child: Text(productState.error ?? 'Error'))
              : ListView.builder(
                  itemCount: productState.products.length,
                  itemBuilder: (context, index) {
                    final product = productState.products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('\$${product.price}'),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(productProvider.notifier).fetchAllProducts();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
*/

// ============================================================================
// EXAMPLE 5: Error Handling Best Practices
// ============================================================================

/*
Future<void> errorHandlingExample(WidgetRef ref) async {
  final repository = ref.read(productRepositoryProvider);
  
  try {
    final products = await repository.getAllProducts();
    // Success handling
    print('✅ Success: ${products.length} products');
    
  } on UnauthorizedException catch (e) {
    // Handle 401 - redirect to login
    print('🔐 ${repository.getErrorMessage(e)}');
    
  } on ForbiddenException catch (e) {
    // Handle 403 - show permission error
    print('🚫 ${repository.getErrorMessage(e)}');
    
  } on NotFoundException catch (e) {
    // Handle 404 - show not found error
    print('❌ ${repository.getErrorMessage(e)}');
    
  } on TimeoutException catch (e) {
    // Handle timeout - suggest retry
    print('⏱️ ${repository.getErrorMessage(e)}');
    
  } on NetworkException catch (e) {
    // Handle network error - check internet
    print('🌐 ${repository.getErrorMessage(e)}');
    
  } on ServerException catch (e) {
    // Handle 5xx - show server error
    print('🔴 ${repository.getErrorMessage(e)}');
    
  } on ApiException catch (e) {
    // Handle other API errors
    print('❌ ${repository.getErrorMessage(e)}');
    
  } catch (e) {
    // Handle unknown errors
    print('❌ Unknown error: $e');
  }
}
*/

// ============================================================================
// EXAMPLE 6: Query Parameters
// ============================================================================

/*
Future<void> queryParametersExample(WidgetRef ref) async {
  final repository = ref.read(productRepositoryProvider);
  
  try {
    // Search with filters
    final products = await repository.searchProducts(
      query: 'headphones',
      filters: {
        'minPrice': 100,
        'maxPrice': 300,
        'category': 'electronics',
        'page': 1,
        'limit': 10,
      },
    );
    
    print('✅ Found ${products.length} products');
    
  } on ApiException catch (e) {
    print('❌ Search failed: ${e.message}');
  }
}
*/

// ============================================================================
// EXAMPLE 7: Custom Headers
// ============================================================================

/*
Future<void> customHeadersExample(WidgetRef ref) async {
  final apiService = ref.read(apiServiceProvider);
  
  try {
    final response = await apiService.get<Map<String, dynamic>>(
      endpoint: '/user/profile',
      headers: {
        'Authorization': 'Bearer YOUR_TOKEN',
        'X-Custom-Header': 'custom-value',
      },
      fromJson: (json) => json as Map<String, dynamic>,
    );
    
    if (response.isSuccess) {
      print('✅ Profile: ${response.data}');
    }
    
  } on UnauthorizedException catch (e) {
    print('🔐 Invalid token: ${e.message}');
  }
}
*/

// ============================================================================
// EXAMPLE 8: Pagination
// ============================================================================

/*
Future<void> paginationExample(WidgetRef ref) async {
  final repository = ref.read(productRepositoryProvider);
  
  try {
    // Fetch page 1
    final products = await repository.getAllProducts(
      queryParameters: {
        'page': 1,
        'limit': 20,
      },
    );
    
    print('✅ Fetched ${products.length} products');
    
  } on ApiException catch (e) {
    print('❌ Error: ${e.message}');
  }
}
*/

// ============================================================================
// EXAMPLE 9: Combining Multiple Requests
// ============================================================================

/*
Future<void> multipleRequestsExample(WidgetRef ref) async {
  final productRepository = ref.read(productRepositoryProvider);
  final orderRepository = ref.read(orderRepositoryProvider);
  
  try {
    // Fetch products and orders in parallel
    final results = await Future.wait([
      productRepository.getAllProducts(),
      orderRepository.getAllOrders(),
    ]);
    
    final products = results[0] as List<ProductModel>;
    final orders = results[1] as List<OrderModel>;
    
    print('✅ Fetched ${products.length} products and ${orders.length} orders');
    
  } on ApiException catch (e) {
    print('❌ Error: ${e.message}');
  }
}
*/

// ============================================================================
// EXAMPLE 10: Retry Logic
// ============================================================================

/*
Future<T> retryRequest<T>(
  Future<T> Function() request, {
  int maxRetries = 3,
  Duration delay = const Duration(seconds: 1),
}) async {
  int retries = 0;
  
  while (retries < maxRetries) {
    try {
      return await request();
    } on TimeoutException catch (e) {
      retries++;
      if (retries >= maxRetries) rethrow;
      
      print('⏱️ Timeout, retrying... ($retries/$maxRetries)');
      await Future.delayed(delay);
      
    } on NetworkException catch (e) {
      retries++;
      if (retries >= maxRetries) rethrow;
      
      print('🌐 Network error, retrying... ($retries/$maxRetries)');
      await Future.delayed(delay);
    }
  }
  
  throw Exception('Max retries exceeded');
}

// Usage
Future<void> retryExample(WidgetRef ref) async {
  final repository = ref.read(productRepositoryProvider);
  
  try {
    final products = await retryRequest(
      () => repository.getAllProducts(),
      maxRetries: 3,
    );
    
    print('✅ Successfully fetched products after retries');
    
  } on ApiException catch (e) {
    print('❌ Failed after retries: ${e.message}');
  }
}
*/

// ============================================================================
// এই examples গুলি reference হিসেবে ব্যবহার করুন
// Production code এ এগুলি uncomment করে ব্যবহার করতে পারেন
// ============================================================================

