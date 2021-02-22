import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:project_internship_laundry/data/data_source/token_interceptor.dart';
import 'package:project_internship_laundry/utils/const.dart';

class LoginDataSource {
  Dio dio = new Dio(BaseOptions(baseUrl: '$kBaseUrl/'))
    ..interceptors.add(AppInterceptor());

  Future<Response> check(String token) => dio.post(
        'token/verify/',
        data: {'token': token},
      );

  Future logIn(String email, String password) async {
    try {
      Response response = await dio.post(
        'token/',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return response;
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      debugPrint(e.hashCode.toString());
    }
  }
}
