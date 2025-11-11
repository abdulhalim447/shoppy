import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../../config/constants/app_constants.dart';
import '../exceptions/api_exception.dart';
import '../models/api_response.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: AppConstants.baseUrl);
});

/// Base API Service for handling HTTP requests
class ApiService {
  final String baseUrl;
  final Duration timeout;
  final Map<String, String> defaultHeaders;

  ApiService({required this.baseUrl, this.timeout = const Duration(seconds: 30), Map<String, String>? defaultHeaders})
    : defaultHeaders = defaultHeaders ?? {'Content-Type': 'application/json', 'Accept': 'application/json'};

  /// GET request
  Future<ApiResponse<T>> get<T>({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final url = _buildUrl(endpoint, queryParameters);
      final mergedHeaders = {...defaultHeaders, ...?headers};

      print('🔵 GET Request: $url');
      print('Headers: $mergedHeaders');

      final response = await http
          .get(url, headers: mergedHeaders)
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException();
            },
          );

      print('📊 Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return _handleResponse<T>(response: response, fromJson: fromJson);
    } on ApiException {
      rethrow;
    } catch (e, stackTrace) {
      print('❌ GET Error: $e');
      print('Stack Trace: $stackTrace');
      throw UnknownException(message: 'GET request failed: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// POST request
  Future<ApiResponse<T>> post<T>({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) fromJson,
  }) async {
    try {
      final url = _buildUrl(endpoint, queryParameters);
      final mergedHeaders = {...defaultHeaders, ...?headers};
      final jsonBody = body != null ? jsonEncode(body) : null;

      print('🟢 POST Request: $url');
      print('Headers: $mergedHeaders');
      print('Body: $jsonBody');

      final response = await http
          .post(url, headers: mergedHeaders, body: jsonBody)
          .timeout(
            timeout,
            onTimeout: () {
              throw TimeoutException();
            },
          );

      print('📊 Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      return _handleResponse<T>(response: response, fromJson: fromJson);
    } on ApiException {
      rethrow;
    } catch (e, stackTrace) {
      print('❌ POST Error: $e');
      print('Stack Trace: $stackTrace');
      throw UnknownException(message: 'POST request failed: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Handle HTTP response
  ApiResponse<T> _handleResponse<T>({required http.Response response, required T Function(dynamic) fromJson}) {
    try {
      final statusCode = response.statusCode;

      // Success responses (2xx)
      if (statusCode >= 200 && statusCode < 300) {
        try {
          final jsonData = jsonDecode(response.body);
          final data = fromJson(jsonData);
          return ApiResponse.success(data: data, statusCode: statusCode);
        } catch (e, stackTrace) {
          throw ParseException(message: 'Failed to parse response: $e', originalException: e, stackTrace: stackTrace);
        }
      }

      // Client errors (4xx)
      if (statusCode >= 400 && statusCode < 500) {
        final errorResponse = _parseErrorResponse(response.body);

        switch (statusCode) {
          case 401:
            throw UnauthorizedException(
              message: errorResponse.message,
              code: errorResponse.code,
              originalException: response.body,
            );
          case 403:
            throw ForbiddenException(
              message: errorResponse.message,
              code: errorResponse.code,
              originalException: response.body,
            );
          case 404:
            throw NotFoundException(
              message: errorResponse.message,
              code: errorResponse.code,
              originalException: response.body,
            );
          default:
            throw ClientException(
              message: errorResponse.message,
              code: errorResponse.code,
              statusCode: statusCode,
              originalException: response.body,
            );
        }
      }

      // Server errors (5xx)
      if (statusCode >= 500) {
        final errorResponse = _parseErrorResponse(response.body);
        throw ServerException(
          message: errorResponse.message,
          code: errorResponse.code,
          statusCode: statusCode,
          originalException: response.body,
        );
      }

      // Unknown status code
      throw UnknownException(message: 'Unknown status code: $statusCode', originalException: response.body);
    } on ApiException {
      rethrow;
    } catch (e, stackTrace) {
      throw UnknownException(message: 'Error handling response: $e', originalException: e, stackTrace: stackTrace);
    }
  }

  /// Parse error response
  ApiErrorResponse _parseErrorResponse(String responseBody) {
    try {
      final jsonData = jsonDecode(responseBody);
      return ApiErrorResponse.fromJson(jsonData);
    } catch (e) {
      return ApiErrorResponse(message: responseBody.isNotEmpty ? responseBody : 'Unknown error');
    }
  }

  /// Build URL with query parameters
  Uri _buildUrl(String endpoint, Map<String, dynamic>? queryParameters) {
    final url = '$baseUrl$endpoint';
    return Uri.parse(url).replace(queryParameters: queryParameters);
  }
}
