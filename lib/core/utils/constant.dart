enum BlocState {
  initial,
  loading,
  success,
  failure
}

class Constants {
  static const String unexpectedError = 'UNEXPECTED_ERROR';
  static const String networkError = 'NETWORK_ERROR';
  static const String formatError = 'FORMAT_ERROR';
}

class ApiConstants {
  static const String baseUrl = 'http://your-server-url';  // HTTP API base URL
  static const String wsBaseUrl = 'ws://your-server-url';  // WebSocket base URL

  // WebSocket Task Types
  static const String tradeTask = 'trade';
  static const String stopTradeTask = 'stop_trade';

  // WebSocket Message Keys
  static const String taskKey = 'task';
  static const String uidKey = 'uid';
  static const String paramsKey = 'params';
  static const String positionKey = 'position';
  static const String messageKey = 'message';
  static const String errorKey = 'error';
  static const String statusKey = 'ok';

  // Response Codes
  static const String successCode = 'SUCCESS';
  static const String errorCode = 'ERROR';
  static const String socketErrorCode = 'SOCKET_ERROR';
  static const String unexpectedErrorCode = 'UNEXPECTED_ERROR';
}