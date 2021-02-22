import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class AppInterceptor extends Interceptor {
  final Box token = Hive.box('token');
  final Dio dio;

  AppInterceptor({this.dio});

  @override
  Future onRequest(RequestOptions options) async {
    String accessToken = token.get('access');
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return super.onRequest(options);
  }

  @override
  Future onError(DioError err) async {
    String refreshToken = token.get('refresh');

    if (err.response?.statusCode == HttpStatus.unauthorized) {
      if (refreshToken != null) {
        final Response response =
            await dio.post('token/', data: {'refresh': refreshToken});
        if (response.statusCode == HttpStatus.unauthorized) {
          token.delete('access');
          token.delete('refresh');
        } else if (response.statusCode == HttpStatus.ok) {
          token.put('access', response.data['access']);
          token.put('refresh', response.data['refresh']);

          return dio.request(err.request.path, options: err.request);
        }
      }
    }
    return super.onError(err);
  }
}
