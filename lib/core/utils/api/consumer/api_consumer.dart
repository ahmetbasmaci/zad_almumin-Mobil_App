import 'package:http/http.dart';

abstract class ApiConsumer {
  Future<dynamic> get(String url, {Map<String, dynamic>? params, bool convertToJson = false});
  Future<dynamic> post(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params});
  Future<dynamic> put(String url, {Map<String, dynamic>? body, Map<String, dynamic>? params});
  Future<dynamic> delete(String url, {Map<String, dynamic>? params});
  Future<StreamedResponse> getStream(String url, {Map<String, dynamic>? params});
}
