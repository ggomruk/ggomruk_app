import '../dto/common/response_wrapper/response_wrapper.dart';

class CommonMapper {
  static T mapResponseToModel<T>(
      ResponseWrapper<Map<String, dynamic>> response,
      T Function(Map<String, dynamic>) fromJson,
      ) {
    if (!response.status) {
      throw Exception('API Error: ${response.message}');
    }
    return fromJson(response.data!);
  }
}