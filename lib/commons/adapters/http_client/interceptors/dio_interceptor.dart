import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';

import '../../../erros.dart';

class CustomInterceptors extends InterceptorsWrapper {
  CustomInterceptors();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    //Imprimindo informações do request para debug
    if (kDebugMode) {
      debugPrint(json.encode("BaseURL: ${options.baseUrl}"));
      debugPrint(json.encode("Endpoint: ${options.path}"));
      if (options.headers['access-token'] != null) {
        debugPrint("access-token: ${options.headers['access-token']}");
      }
      if (options.data != null) {
        debugPrint("Payload ${json.encode(options.data)}");
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint("response: ${json.encode(response.data)}");
    handler.next(response);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    HttpClientError failure;
    if (err.response?.statusCode == 401) {
      failure = HttpClientError(
          message: 'Falha ao realizar login.',
          requestOptions: err.requestOptions,
          statusCode: err.response?.statusCode,
          stackTrace: err.stackTrace,
          type: err.type,
          data: err.requestOptions.data,
          error: err,
          response: err.response);
    } else {
      failure = HttpClientError(
          requestOptions: err.requestOptions,
          statusCode: err.response?.statusCode,
          stackTrace: err.stackTrace,
          type: err.type,
          data: err.requestOptions.data,
          error: err,
          response: err.response,
          message: 'Ocorreu um erro na requisição com o servidor');
    }

    handler.next(failure);
  }


}
