import 'package:dio/dio.dart';
import 'package:project_internship_laundry/data/data_source/token_interceptor.dart';
import 'package:project_internship_laundry/data/model/product_model.dart';
import 'package:project_internship_laundry/utils/const.dart';

class ProductsDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: '$kBaseUrl/products/'))
    ..interceptors.add(AppInterceptor());

  Future<List<Product>> getProducts(String title) async {
    Response response = await dio.get('?search=$title');

    return (response.data as List).map((e) => Product.fromJson(e)).toList();
  }
}
