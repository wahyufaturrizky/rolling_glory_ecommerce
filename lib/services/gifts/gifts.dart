/*
 * Sekuya Family Mobile App
 * Created by Wahyu Fatur Rizki
 * https://www.linkedin.com/in/wahyu-fatur-rizky/
 * 
 * Copyright (c) 2024 Wahyu Fatur Rizki, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:rolling_glory_ecommerce/services/client.dart';

Future<dynamic> handleGetDataGifts(queryParameters) {
  return clientDio(
      serviceUrlParam: "/gifts",
      methodParam: "GET",
      queryParameters: queryParameters);
}

Future<dynamic> handleGetDataGiftsDetail(idGift) {
  return clientDio(
    serviceUrlParam: "/gifts/$idGift",
    methodParam: "GET",
  );
}

Future<dynamic> handleWhislistGifts(data, idGift) {
  return clientDio(
    serviceUrlParam: '/gifts/$idGift/wishlist',
    methodParam: "POST",
    data: data,
  );
}
