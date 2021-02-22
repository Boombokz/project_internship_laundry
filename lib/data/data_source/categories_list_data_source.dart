import 'package:dio/dio.dart';
import 'package:project_internship_laundry/data/data_source/token_interceptor.dart';
import 'package:project_internship_laundry/data/model/product_category_model.dart';
import 'package:project_internship_laundry/utils/const.dart';

class CategoriesListDataSource {
  Dio dio = Dio(BaseOptions(baseUrl: '$kBaseUrl/products/'))
    ..interceptors.add(AppInterceptor());

  Future<List<ProductCategory>> getCategories() async {
    Response response = await dio.get('categories/');

    return (response.data as List)
        .map((e) => ProductCategory.fromJson(e))
        .toList();
  }
}
