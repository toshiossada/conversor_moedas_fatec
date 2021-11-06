import 'package:dio/dio.dart';

import '../../erros.dart';
import 'interfaces/http_client_adapter.dart';
import 'http_response.dart';

class DioAdapter implements IHttpClientAdapter {
  final Dio dio;
  final List<InterceptorsWrapper> insterceptors;

  DioAdapter({
    required this.dio,
    required this.insterceptors,
  }) {
    dio.interceptors.addAll(insterceptors);
  }

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      HttpResponse response = HttpResponse(
        data: result.data,
        statusCode: result.statusCode ?? 200,
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw HttpClientError(
          data: e.response?.data,
          statusCode: e.response?.statusCode ?? 500,
          type: DioErrorType.response,
          message: e.message,
          requestOptions: e.requestOptions,
        );
      }
      rethrow;
    }
  }

  @override
  Future<HttpResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      HttpResponse response = HttpResponse(
        data: result.data,
        statusCode: result.statusCode ?? 200,
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw HttpClientError(
          data: e.response?.data,
          statusCode: e.response?.statusCode ?? 500,
          type: DioErrorType.response,
          message: e.message,
          requestOptions: e.requestOptions,
        );
      }
      rethrow;
    }
  }

  @override
  Future<HttpResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await dio.put(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      HttpResponse response = HttpResponse(
        data: result.data,
        statusCode: result.statusCode ?? 200,
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw HttpClientError(
          data: e.response?.data,
          statusCode: e.response?.statusCode ?? 500,
          type: DioErrorType.response,
          message: e.message,
          requestOptions: e.requestOptions,
        );
      }
      rethrow;
    }
  }

  @override
  Future<HttpResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final result = await dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      HttpResponse response = HttpResponse(
        data: result.data,
        statusCode: result.statusCode ?? 200,
      );
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        throw HttpClientError(
          data: e.response?.data,
          statusCode: e.response?.statusCode ?? 500,
          type: DioErrorType.response,
          message: e.message,
          requestOptions: e.requestOptions,
        );
      }
      rethrow;
    }
  }
}
