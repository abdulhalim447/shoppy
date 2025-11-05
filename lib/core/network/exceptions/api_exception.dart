/// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  final String? code;
  final dynamic originalException;
  final StackTrace? stackTrace;

  ApiException({
    required this.message,
    this.code,
    this.originalException,
    this.stackTrace,
  });

  @override
  String toString() => 'ApiException: $message (Code: $code)';
}

/// Exception for network errors
class NetworkException extends ApiException {
  NetworkException({
    String message = 'Network error occurred',
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'NETWORK_ERROR',
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for server errors (5xx)
class ServerException extends ApiException {
  final int? statusCode;

  ServerException({
    String message = 'Server error occurred',
    String? code,
    this.statusCode,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'SERVER_ERROR',
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for client errors (4xx)
class ClientException extends ApiException {
  final int? statusCode;

  ClientException({
    String message = 'Client error occurred',
    String? code,
    this.statusCode,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'CLIENT_ERROR',
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for unauthorized access (401)
class UnauthorizedException extends ClientException {
  UnauthorizedException({
    String message = 'Unauthorized access',
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'UNAUTHORIZED',
    statusCode: 401,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for forbidden access (403)
class ForbiddenException extends ClientException {
  ForbiddenException({
    String message = 'Access forbidden',
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'FORBIDDEN',
    statusCode: 403,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for not found (404)
class NotFoundException extends ClientException {
  NotFoundException({
    String message = 'Resource not found',
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'NOT_FOUND',
    statusCode: 404,
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for timeout
class TimeoutException extends ApiException {
  TimeoutException({
    String message = 'Request timeout',
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'TIMEOUT',
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for parsing errors
class ParseException extends ApiException {
  ParseException({
    String message = 'Failed to parse response',
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'PARSE_ERROR',
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

/// Exception for unknown errors
class UnknownException extends ApiException {
  UnknownException({
    String message = 'Unknown error occurred',
    String? code,
    dynamic originalException,
    StackTrace? stackTrace,
  }) : super(
    message: message,
    code: code ?? 'UNKNOWN_ERROR',
    originalException: originalException,
    stackTrace: stackTrace,
  );
}

