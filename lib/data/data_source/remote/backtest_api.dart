import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../dto/backtest/backtest_dto.dart';
import '../../dto/common/response_wrapper/response_wrapper.dart';
import 'backtest_api_interface.dart';

class BacktestApiClient implements BacktestApiInterface {
  final String baseUrl;
  final http.Client httpClient;

  BacktestApiClient({
    required this.baseUrl,
    http.Client? httpClient,
  }) : this.httpClient = httpClient ?? http.Client();

  @override
  Future<ResponseWrapper<Map<String, dynamic>>> runBacktest(BacktestDto backtestDto) async {
    final url = Uri.parse('$baseUrl/api/algo/backtest');
    try {
      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(backtestDto.toJson()),
      );

      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      return ResponseWrapper<Map<String, dynamic>>.fromJson(
        responseBody,
            (json) => json as Map<String, dynamic>,
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseWrapper<List<String>>> getAvailableSymbols() async {
    final url = Uri.parse('$baseUrl/api/algo/symbols');
    try {
      final response = await httpClient.get(url);
      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      return ResponseWrapper<List<String>>.fromJson(
        responseBody,
            (json) => (json as List).cast<String>(),
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  @override
  Future<ResponseWrapper<Map<String, Map<String, dynamic>>>> getAvailableStrategies() async {
    final url = Uri.parse('$baseUrl/api/algo/strategies');
    try {
      final response = await httpClient.get(url);
      final responseBody = json.decode(response.body) as Map<String, dynamic>;

      return ResponseWrapper<Map<String, Map<String, dynamic>>>.fromJson(
        responseBody,
            (json) => (json as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, value as Map<String, dynamic>),
        ),
      );
    } catch (e) {
      return _handleError(e);
    }
  }

  ResponseWrapper<T> _handleError<T>(dynamic error) {
    if (error is FormatException) {
      return ResponseWrapper(
        status: false,
        code: 'FORMAT_ERROR',
        message: 'Invalid response format',
      );
    } else if (error is http.ClientException) {
      return ResponseWrapper(
        status: false,
        code: 'NETWORK_ERROR',
        message: 'Network error occurred',
      );
    }
    return ResponseWrapper(
      status: false,
      code: 'UNEXPECTED_ERROR',
      message: 'An unexpected error occurred',
    );
  }
}