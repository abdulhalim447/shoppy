/// Generic API response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? message;
  final String? code;
  final int? statusCode;
  final dynamic error;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.code,
    this.statusCode,
    this.error,
  });

  /// Create a success response
  factory ApiResponse.success({
    required T data,
    String? message,
    int? statusCode,
  }) {
    return ApiResponse(
      success: true,
      data: data,
      message: message ?? 'Success',
      statusCode: statusCode ?? 200,
    );
  }

  /// Create an error response
  factory ApiResponse.error({
    required String message,
    String? code,
    int? statusCode,
    dynamic error,
  }) {
    return ApiResponse(
      success: false,
      message: message,
      code: code,
      statusCode: statusCode ?? 500,
      error: error,
    );
  }

  /// Check if response is successful
  bool get isSuccess => success;

  /// Check if response is error
  bool get isError => !success;

  @override
  String toString() {
    return 'ApiResponse(success: $success, message: $message, code: $code, statusCode: $statusCode)';
  }
}

/// Paginated API response
class PaginatedApiResponse<T> extends ApiResponse<List<T>> {
  final int page;
  final int pageSize;
  final int totalItems;
  final int totalPages;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginatedApiResponse({
    required bool success,
    required List<T> data,
    String? message,
    String? code,
    int? statusCode,
    dynamic error,
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  }) : super(
    success: success,
    data: data,
    message: message,
    code: code,
    statusCode: statusCode,
    error: error,
  );

  /// Create a success paginated response
  factory PaginatedApiResponse.success({
    required List<T> data,
    required int page,
    required int pageSize,
    required int totalItems,
    String? message,
    int? statusCode,
  }) {
    final totalPages = (totalItems / pageSize).ceil();
    final hasNextPage = page < totalPages;
    final hasPreviousPage = page > 1;

    return PaginatedApiResponse(
      success: true,
      data: data,
      message: message ?? 'Success',
      statusCode: statusCode ?? 200,
      page: page,
      pageSize: pageSize,
      totalItems: totalItems,
      totalPages: totalPages,
      hasNextPage: hasNextPage,
      hasPreviousPage: hasPreviousPage,
    );
  }

  /// Create an error paginated response
  factory PaginatedApiResponse.error({
    required String message,
    String? code,
    int? statusCode,
    dynamic error,
  }) {
    return PaginatedApiResponse(
      success: false,
      data: [],
      message: message,
      code: code,
      statusCode: statusCode ?? 500,
      error: error,
      page: 0,
      pageSize: 0,
      totalItems: 0,
      totalPages: 0,
      hasNextPage: false,
      hasPreviousPage: false,
    );
  }
}

/// API error response model
class ApiErrorResponse {
  final String message;
  final String? code;
  final Map<String, dynamic>? errors;
  final int? statusCode;

  ApiErrorResponse({
    required this.message,
    this.code,
    this.errors,
    this.statusCode,
  });

  /// Create from JSON
  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      message: json['message'] as String? ?? 'Unknown error',
      code: json['code'] as String?,
      errors: json['errors'] as Map<String, dynamic>?,
      statusCode: json['statusCode'] as int?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'errors': errors,
      'statusCode': statusCode,
    };
  }

  @override
  String toString() {
    return 'ApiErrorResponse(message: $message, code: $code, statusCode: $statusCode)';
  }
}

