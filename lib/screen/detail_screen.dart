/*
 * Rolling Glory Mobile App
 * Created by Wahyu Fatur Rizki
 * https://www.linkedin.com/in/wahyu-fatur-rizky/
 * 
 * Copyright (c) 2024 Wahyu Fatur Rizki, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
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
        body: SingleChildScrollView(
            child: Stack(
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
                  HtmlWidget(
                    '''${widget.detailData?["attributes"]?["info"]}''',
                    renderMode: RenderMode.column,
                    textStyle:
                        const TextStyle(fontSize: 12, color: greySoftColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: const BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: greyColor,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                                children: List.generate(
                              int.parse(widget.detailData?["attributes"]
                                      ?["rating"]
                                  .toStringAsFixed(0)),
                              (index) => Image.asset(
                                  "lib/assets/images/ic_star.png",
                                  height: 12,
                                  width: 12),
                            )),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "${widget.detailData?["attributes"]?["numOfReviews"] ?? ""}",
                              style: const TextStyle(
                                  fontSize: 12, color: greySoftColor),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            const Text(
                              "reviews",
                              style:
                                  TextStyle(fontSize: 12, color: greySoftColor),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: const BoxDecoration(
                            border: Border.symmetric(
                              vertical: BorderSide(
                                color: greyColor,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "lib/assets/images/ic_point_detail.png",
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${widget.detailData?["attributes"]?["points"] ?? ""}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: greenColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              const Text(
                                "Points",
                                style: TextStyle(
                                    fontSize: 12, color: greySoftColor),
                              ),
                            ],
                          ),
                        ),
                        const Column(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: greySolidColor,
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Add to wishlist",
                              style:
                                  TextStyle(fontSize: 12, color: greySoftColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Row(
                    children: [
                      Text(
                        "Info Produk",
                        style: TextStyle(color: darkBlueColor, fontSize: 14),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  HtmlWidget(
                    '''${widget.detailData?["attributes"]?["description"]}''',
                    renderMode: RenderMode.column,
                    textStyle:
                        const TextStyle(fontSize: 14, color: darkBlueColor),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("-"),
                            Text(
                              "1",
                            ),
                            Text("+")
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(color: greenColor, width: 1),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Text("Add to cart",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: greenColor))),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: greenColor,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Text("Redeem",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  )
                ],
              ),
            ),
            if (widget.detailData?["attributes"]?["isNew"] == 1)
              Container(
                  alignment: Alignment.topRight,
                  child: Image.asset("lib/assets/images/ic_new.png"))
          ],
        )));
  }
}
