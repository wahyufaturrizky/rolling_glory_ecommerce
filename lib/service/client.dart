/*
 * Rolling Glory Mobile App
 * Created by Wahyu Fatur Rizki
 * https://www.linkedin.com/in/wahyu-fatur-rizky/
 * 
 * Copyright (c) 2024 Wahyu Fatur Rizki, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rolling_glory_ecommerce/constants.dart';

final dio = Dio()
  ..options.baseUrl = baseUrl
  ..interceptors.addAll(
    [
      QueuedInterceptorsWrapper(
        onError: (error, handler) async {
          print('onError $error');

          if (error.response == null) return handler.next(error);

          /// When request fails with 401 status code, request new CSRF token
          if (error.response?.statusCode == 401) {
            print('Error 401 $error');
          }
        },
      ),
    ],
  );

Future<dynamic> clientDio(
    {serviceUrlParam = "", methodParam = "GET", data, queryParameters}) async {
  try {
    String serviceUrl = serviceUrlParam;
    String method = methodParam;

    final response = await dio.request(serviceUrl,
        options: Options(
          method: method,
        ),
        queryParameters: queryParameters,
        data: data);
    print('@client response $response');

    var decodeJsonRes = jsonDecode(response.toString());

    return decodeJsonRes;
  } on DioException catch (e) {
    print('@client error $e');
    if (e.response != null) {
      print(e.response?.data);
      print(e.response?.headers);
      print(e.response?.requestOptions);
    } else {
      print(e.requestOptions);
      print(e.message);
    }
  }
}
