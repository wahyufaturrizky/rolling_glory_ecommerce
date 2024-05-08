/*
 * Rolling Glory Mobile App
 * Created by Wahyu Fatur Rizki
 * https://www.linkedin.com/in/wahyu-fatur-rizky/
 * 
 * Copyright (c) 2024 Wahyu Fatur Rizki, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:rolling_glory_ecommerce/constants.dart';

class MyDetailPageApp extends StatelessWidget {
  const MyDetailPageApp({super.key, this.detailData});

  final dynamic detailData;

  @override
  Widget build(BuildContext context) {
    return MyDetailPage(detailData: detailData);
  }
}

class MyDetailPage extends StatefulWidget {
  const MyDetailPage({super.key, this.detailData});

  final dynamic detailData;

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    print(widget.detailData);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Gift detail',
            style: TextStyle(color: darkBlueColor),
          ),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  border: Border.all(color: greyColor, width: 1),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  )),
              child: Column(
                children: [
                  if (widget.detailData?["attributes"]?["images"] != null &&
                      widget.detailData?["attributes"]?["images"][0] !=
                          "https://rgbtest.s3.ap-southeast-1.amazonaws.com/images/gift/full/xiaomi-mi-10-pro-5g.jpg")
                    Image.network(
                      widget.detailData?["attributes"]?["images"]?[0],
                      fit: BoxFit.contain,
                      width: 245,
                      height: 325,
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                        widget.detailData?["attributes"]?["name"] ?? "",
                        style:
                            const TextStyle(color: darkBlueColor, fontSize: 24),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                        widget.detailData?["attributes"]?["info"],
                        style: const TextStyle(fontSize: 12, color: greyColor),
                      ))
                    ],
                  ),
                ],
              ),
            ),
            if (widget.detailData?["attributes"]?["isNew"] == 1)
              Container(
                  alignment: Alignment.topRight,
                  child: Image.asset("lib/assets/images/ic_new.png"))
          ],
        ));
  }
}
