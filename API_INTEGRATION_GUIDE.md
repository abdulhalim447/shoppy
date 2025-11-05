# API Integration Guide - SHOPPY

## 📋 Overview

এই গাইড দেখায় কীভাবে SHOPPY অ্যাপে API integration করতে হয়। আমরা একটি production-ready template তৈরি করেছি যা সহজেই যেকোনো API এর সাথে কাজ করতে পারে।

## 🏗️ Architecture

```
API Service Layer
    ↓
Repository Pattern
    ↓
Provider (State Management)
    ↓
UI Layer
```

## 📁 File Structure

```
lib/
├── core/network/
│   ├── exceptions/
│   │   └── api_exception.dart          # Custom exceptions
│   ├── models/
│   │   └── api_response.dart           # Response models
│   ├── services/
│   │   └── api_service.dart            # Base API service
│   └── repositories/
│       └── base_repository.dart        # Base repository
│
└── features/
    └── home/
        ├── data/
        │   ├── models/
        │   │   └── product_model.dart
        │   └── repositories/
        │       └── product_repository.dart
        └── presentation/
            └── providers/
                └── product_provider.dart
```

## 🔧 Components

### 1. API Service (`api_service.dart`)

Base HTTP client যা GET এবং POST requests handle করে।

**Features:**
- Automatic error handling
- Timeout management
- Request/Response logging
- Custom headers support
- Query parameters support

### 2. Exception Handling (`api_exception.dart`)

Custom exceptions যা বিভিন্ন error scenarios handle করে:

- `ApiException` - Base exception
- `NetworkException` - Network errors
- `ServerException` - 5xx errors
- `ClientException` - 4xx errors
- `UnauthorizedException` - 401 errors
- `ForbiddenException` - 403 errors
- `NotFoundException` - 404 errors
- `TimeoutException` - Timeout errors
- `ParseException` - JSON parsing errors

### 3. Response Models (`api_response.dart`)

Generic response wrapper:

```dart
ApiResponse<T> {
  bool success;
  T? data;
  String? message;
  String? code;
  int? statusCode;
  dynamic error;
}
```

### 4. Repository Pattern (`base_repository.dart`)

Base repository যা API calls wrap করে error handling সহ।

### 5. Feature Repository (`product_repository.dart`)

Specific feature এর জন্য repository যা BaseRepository extend করে।

### 6. Provider (`product_provider.dart`)

State management using Riverpod।

## 💻 Usage Examples

### Example 1: GET Request

```dart
// Repository method
Future<List<ProductModel>> getAllProducts() async {
  return await executeGet<List<ProductModel>>(
    endpoint: '/products',
    fromJson: (json) {
      if (json is List) {
        return json
            .map((item) => ProductModel.fromJson(item))
            .toList();
      }
      throw ParseException();
    },
  );
}

// In UI
final products = ref.watch(productProvider);

if (products.isLoading) {
  return CircularProgressIndicator();
}

if (products.hasError) {
  return Text('Error: ${products.error}');
}

return ListView.builder(
  itemCount: products.products.length,
  itemBuilder: (context, index) {
    return ProductCard(product: products.products[index]);
  },
);
```

### Example 2: POST Request

```dart
// Repository method
Future<ProductModel> createProduct({
  required Map<String, dynamic> productData,
}) async {
  return await executePost<ProductModel>(
    endpoint: '/products',
    body: productData,
    fromJson: (json) => ProductModel.fromJson(json),
  );
}

// In UI
ref.read(productProvider.notifier).createProduct(
  productData: {
    'name': 'New Product',
    'price': 199.99,
    'description': 'Product description',
  },
);
```

### Example 3: Error Handling

```dart
try {
  final products = await repository.getAllProducts();
  // Handle success
} on UnauthorizedException catch (e) {
  // Handle 401 - redirect to login
  print('Session expired: ${e.message}');
} on NotFoundException catch (e) {
  // Handle 404
  print('Resource not found: ${e.message}');
} on TimeoutException catch (e) {
  // Handle timeout
  print('Request timeout: ${e.message}');
} on ApiException catch (e) {
  // Handle other API errors
  print('API Error: ${e.message}');
} catch (e) {
  // Handle unknown errors
  print('Unknown error: $e');
}
```

## 🚀 Creating New API Endpoints

### Step 1: Create Repository

```dart
class OrderRepository extends BaseRepository {
  OrderRepository({required ApiService apiService})
      : super(apiService: apiService);

  Future<List<OrderModel>> getOrders() async {
    return await executeGet<List<OrderModel>>(
      endpoint: '/orders',
      fromJson: (json) {
        if (json is List) {
          return json
              .map((item) => OrderModel.fromJson(item))
              .toList();
        }
        throw ParseException();
      },
    );
  }

  Future<OrderModel> createOrder({
    required Map<String, dynamic> orderData,
  }) async {
    return await executePost<OrderModel>(
      endpoint: '/orders',
      body: orderData,
      fromJson: (json) => OrderModel.fromJson(json),
    );
  }
}
```

### Step 2: Create Provider

```dart
final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OrderRepository(apiService: apiService);
});

class OrderState {
  final List<OrderModel> orders;
  final bool isLoading;
  final String? error;
  // ... other fields
}

class OrderNotifier extends StateNotifier<OrderState> {
  final OrderRepository _repository;

  OrderNotifier(this._repository) : super(OrderState());

  Future<void> fetchOrders() async {
    try {
      state = state.copyWith(isLoading: true);
      final orders = await _repository.getOrders();
      state = state.copyWith(orders: orders, isLoading: false);
    } on ApiException catch (e) {
      state = state.copyWith(
        error: _repository.getErrorMessage(e),
        isLoading: false,
      );
    }
  }
}

final orderProvider = StateNotifierProvider<OrderNotifier, OrderState>((ref) {
  final repository = ref.watch(orderRepositoryProvider);
  return OrderNotifier(repository);
});
```

### Step 3: Use in UI

```dart
class OrderListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderProvider);

    return Scaffold(
      body: orderState.isLoading
          ? Center(child: CircularProgressIndicator())
          : orderState.hasError
              ? Center(child: Text(orderState.error ?? 'Error'))
              : ListView.builder(
                  itemCount: orderState.orders.length,
                  itemBuilder: (context, index) {
                    return OrderCard(order: orderState.orders[index]);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(orderProvider.notifier).fetchOrders();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
```

## 🔐 Authentication

### Adding Auth Headers

```dart
final authTokenProvider = StateProvider<String?>((ref) => null);

final apiServiceProvider = Provider<ApiService>((ref) {
  final token = ref.watch(authTokenProvider);
  
  return ApiService(
    baseUrl: AppConstants.baseUrl,
    defaultHeaders: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
  );
});
```

## 📊 Error Messages (Bengali)

- **Unauthorized**: "আপনার সেশন শেষ হয়েছে। দয়া করে আবার লগইন করুন।"
- **Forbidden**: "আপনার এই অ্যাকশনের অনুমতি নেই।"
- **Not Found**: "অনুরোধকৃত রিসোর্স পাওয়া যায়নি।"
- **Timeout**: "অনুরোধ সময়মত সম্পন্ন হয়নি। দয়া করে আবার চেষ্টা করুন।"
- **Network Error**: "নেটওয়ার্ক সংযোগ ত্রুটি। দয়া করে আপনার ইন্টারনেট সংযোগ পরীক্ষা করুন।"
- **Server Error**: "সার্ভার ত্রুটি। দয়া করে পরে আবার চেষ্টা করুন।"

## 🧪 Testing

```dart
// Mock API Service
class MockApiService extends Mock implements ApiService {}

// Test
test('getAllProducts returns list of products', () async {
  final mockApiService = MockApiService();
  final repository = ProductRepository(apiService: mockApiService);

  when(mockApiService.get(
    endpoint: '/products',
    fromJson: anyNamed('fromJson'),
  )).thenAnswer((_) async => ApiResponse.success(data: []));

  final result = await repository.getAllProducts();
  expect(result, isA<List<ProductModel>>());
});
```

## 📝 Best Practices

1. **Always use try-catch** in repositories
2. **Log errors** for debugging
3. **Use specific exceptions** for different error types
4. **Provide user-friendly error messages** in Bengali
5. **Handle timeouts** gracefully
6. **Validate responses** before parsing
7. **Use immutable models** for data
8. **Keep repositories focused** on data operations
9. **Use providers** for state management
10. **Test error scenarios** thoroughly

## 🔗 API Configuration

Update `lib/config/constants/app_constants.dart`:

```dart
static const String baseUrl = 'https://api.shoppy.com';
static const String productsEndpoint = '/products';
static const String ordersEndpoint = '/orders';
static const String usersEndpoint = '/users';
```

---

**Ready to integrate APIs! 🚀**

