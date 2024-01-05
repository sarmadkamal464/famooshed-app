import 'dart:async';

import 'package:famooshed/app/common/constants.dart';
import 'package:famooshed/app/common/storage/storage.dart';
import 'package:get/get.dart';

import 'api_helper.dart';

class ApiHelperImpl extends GetConnect with ApiHelper {
  @override
  void onInit() {
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = Constants.timeout;

    addRequestModifier();

    httpClient.addResponseModifier((request, response) {
      printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );

      return response;
    });
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData(Constants.token)) {
        request.headers['Authorization'] = Storage.getValue(Constants.token);
      }

      printInfo(
        info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );

      return request;
    });
  }

  @override
  Future<Response<dynamic>> getPosts() {
    return get('posts');
  }

  @override
  Future<Response> postApiCall(url, body) => post(url, body);

  @override
  Future<Response> signIn(url, body) => post(url, body);

  @override
  Future<Response> getApiCall(url) => get(url);

  @override
  Future<Response> getHome(url) => get(url);

  @override
  Future<Response> addBasket(url, body) => post(url, body);

  @override
  Future<Response> getBasket(url, body) => post(url, body);

  @override
  Future<Response> getRestaurantsByCat(url) => get(url);
  @override
  Future<Response> getRestaurantsByCatNew(url) => get(url);

  @override
  Future<Response> saveAddress(url, body) => post(url, body);
}
