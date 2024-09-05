import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../dto/backtest_dto.dart';
import '../../dto/common/response_wrapper/response_wrapper.dart';

class BacktestApiClient {
  final String baseUrl;
  final http.Client httpClient;

  BacktestApiClient({
    required this.baseUrl,
    http.Client? httpClient,
  }) : this.httpClient = httpClient ?? http.Client();

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
    } on FormatException {
      return ResponseWrapper(
        status: false,
        code: 'FORMAT_ERROR',
        message: 'Invalid response format',
      );
    } on http.ClientException {
      return ResponseWrapper(
        status: false,
        code: 'NETWORK_ERROR',
        message: 'Network error occurred',
      );
    } catch (e) {
      return ResponseWrapper(
        status: false,
        code: 'UNEXPECTED_ERROR',
        message: 'An unexpected error occurred',
      );
    }
  }
}