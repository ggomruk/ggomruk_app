import '../error/error_response.dart';

class CommonException implements Exception {
  final ErrorResponse errorResponse;

  CommonException({
    required String status,
    required String code,
    required String message,
  }) : errorResponse = ErrorResponse(
    status: status,
    code: code,
    message: message,
  );

  @override
  String toString() {
    return 'CommonException: [${errorResponse.status}] ${errorResponse.code}: ${errorResponse.message}';
  }
}

class NetworkException extends CommonException {
  NetworkException({String message = 'A network error occurred'})
      : super(status: 'network error', code: 'NETWORK_ERROR', message: message);
}

class ServerException extends CommonException {
  ServerException({String message = 'A server error occurred'})
      : super(status: 'server error', code: 'SERVER_ERROR', message: message);
}

class UnauthorizedException extends CommonException {
  UnauthorizedException({String message = 'Unauthorized access'})
      : super(status: 'unauthorized error', code: 'UNAUTHORIZED', message:
  message);
}

class NotFoundException extends CommonException {
  NotFoundException({String message = 'Resource not found'})
      : super(status: 'not found error', code: 'NOT_FOUND', message: message);
}

class UnexpectedException extends CommonException {
  UnexpectedException({String message = 'An unexpected error occurred'})
      : super(status: 'unexpected error', code: 'UNEXPECTED_ERROR', message:
  message);
}

ErrorResponse createErrorResponse(CommonException exception) {
  return exception.errorResponse;
}