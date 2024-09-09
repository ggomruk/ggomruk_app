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