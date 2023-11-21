import 'package:dio/dio.dart' as d;
import 'package:get/get.dart';

export 'package:famooshed/app/common/util/extensions.dart';
export 'package:famooshed/app/common/util/utils.dart';

mixin ApiHelper implements GetConnect {
  static ApiHelper get to => Get.find();

  Future<Response> getPosts();
  Future<Response> postApiCall(url, body);

  Future<Response> signIn(url, body);
  Future<Response> getApiCall(url);
  Future<Response> getHome(url);
  Future<Response> addBasket(url, body);
  Future<Response> getBasket(url, body);
  Future<Response> getRestaurantsByCat(url);
  Future<Response> saveAddress(url, body);

  Future<d.Response> postApiNew(
      String url, Map<String, dynamic> headers, var body) async {
    d.Dio dio = d.Dio();

    headers.addAll({"x-api-key": 'BBk[2?/k&VOpb[dYJb%0'});

    return await dio.post(url,
        data: body, options: d.Options(headers: headers));
  }

  Future<d.Response> getApiNew(
    String url,
    Map<String, dynamic> headers,
    Map<String, dynamic> queryParams,
  ) async {
    d.Dio dio = d.Dio();

    headers.addAll({"x-api-key": 'BBk[2?/k&VOpb[dYJb%0'});

    return await dio.get(url,
        options: d.Options(
          headers: headers,
        ),
        queryParameters: queryParams);
  }
}
