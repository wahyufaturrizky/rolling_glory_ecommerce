/*
 * Rolling Glory Mobile App
 * Created by Wahyu Fatur Rizki
 * https://www.linkedin.com/in/wahyu-fatur-rizky/
 * 
 * Copyright (c) 2024 Wahyu Fatur Rizki, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rolling_glory_ecommerce/routes.dart';
import 'package:rolling_glory_ecommerce/service/client.dart';

void main() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
        print('REQUEST[${options.method}] => PATH: ${options.path}');
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        print(
            'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        print(
            'ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');

        return handler.next(error);
      },
    ),
  );

  runApp(const MyApp());
}
