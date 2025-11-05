import '../services/api_service.dart';
import '../models/api_response.dart';
import '../exceptions/api_exception.dart';

/// Base repository for handling API calls with error handling
abstract class BaseRepository {
  final ApiService apiService;

  BaseRepository({required this.apiService});

  /// Execute GET request with error handling
  Future<T> executeGet<T>({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await apiService.get<T>(
        endpoint: endpoint,
        headers: headers,
        queryParameters: queryParameters,
        fromJson: fromJson,
      );

      if (response.isSuccess && response.data != null) {
        return response.data as T;
      } else {
        throw ApiException(
          message: response.message ?? 'Unknown error',
          code: response.code,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw UnknownException(
        message: 'GET request failed: $e',
        originalException: e,
      );
    }
  }

  /// Execute POST request with error handling
  Future<T> executePost<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final response = await apiService.post<T>(
        endpoint: endpoint,
        body: body,
        headers: headers,
        queryParameters: queryParameters,
        fromJson: fromJson,
      );

      if (response.isSuccess && response.data != null) {
        return response.data as T;
      } else {
        throw ApiException(
          message: response.message ?? 'Unknown error',
          code: response.code,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw UnknownException(
        message: 'POST request failed: $e',
        originalException: e,
      );
    }
  }

  /// Handle API exceptions and convert to user-friendly messages
  String getErrorMessage(dynamic exception) {
    if (exception is UnauthorizedException) {
      return 'আপনার সেশন শেষ হয়েছে। দয়া করে আবার লগইন করুন।';
    } else if (exception is ForbiddenException) {
      return 'আপনার এই অ্যাকশনের অনুমতি নেই।';
    } else if (exception is NotFoundException) {
      return 'অনুরোধকৃত রিসোর্স পাওয়া যায়নি।';
    } else if (exception is TimeoutException) {
      return 'অনুরোধ সময়মত সম্পন্ন হয়নি। দয়া করে আবার চেষ্টা করুন।';
    } else if (exception is NetworkException) {
      return 'নেটওয়ার্ক সংযোগ ত্রুটি। দয়া করে আপনার ইন্টারনেট সংযোগ পরীক্ষা করুন।';
    } else if (exception is ServerException) {
      return 'সার্ভার ত্রুটি। দয়া করে পরে আবার চেষ্টা করুন।';
    } else if (exception is ClientException) {
      return 'অনুরোধ প্রক্রিয়াকরণে ত্রুটি।';
    } else if (exception is ParseException) {
      return 'ডেটা প্রক্রিয়াকরণে ত্রুটি।';
    } else if (exception is ApiException) {
      return exception.message;
    } else {
      return 'একটি অপ্রত্যাশিত ত্রুটি ঘটেছে। দয়া করে আবার চেষ্টা করুন।';
    }
  }

  /// Log error for debugging
  void logError(dynamic exception, StackTrace? stackTrace) {
    print('❌ Error: $exception');
    if (stackTrace != null) {
      print('Stack Trace: $stackTrace');
    }
  }
}

