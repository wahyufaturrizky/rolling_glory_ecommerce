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

class MyCardApp extends StatelessWidget {
  const MyCardApp(
      {super.key, this.onTap, this.resGifts, this.index, this.onTapWhisList});

  final resGifts;
  final index;
  final Function()? onTapWhisList;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MyCard(
        onTap: onTap,
        resGifts: resGifts,
        index: index,
        onTapWhisList: onTapWhisList);
  }
}

class MyCard extends StatefulWidget {
  const MyCard(
      {super.key, this.onTap, this.resGifts, this.index, this.onTapWhisList});

  final Function()? onTap;
  final resGifts;
  final index;
  final Function()? onTapWhisList;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return GestureDetector(
        onTap: () {
          widget.onTap!();
        },
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
                  if (widget.resGifts?["data"]?[widget.index]?["attributes"]
                              ?["images"] !=
                          null &&
                      widget.resGifts?["data"]?[widget.index]?["attributes"]
                              ?["images"][0] !=
                          "https://rgbtest.s3.ap-southeast-1.amazonaws.com/images/gift/full/xiaomi-mi-10-pro-5g.jpg")
                    Image.network(
                      widget.resGifts?["data"]?[widget.index]?["attributes"]
                          ?["images"]?[0],
                      fit: BoxFit.contain,
                      width: 100,
                      height: 135,
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                        widget.resGifts?["data"]?[widget.index]?["attributes"]
                                ?["name"] ??
                            "",
                        style:
                            const TextStyle(color: darkBlueColor, fontSize: 12),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "lib/assets/images/ic_point.png",
                        height: 12,
                        width: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${widget.resGifts?["data"]?[widget.index]?["attributes"]?["points"] ?? ""} poins",
                        style: const TextStyle(color: greenColor, fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              children: List.generate(
                            int.parse(widget.resGifts?["data"]?[widget.index]
                                    ?["attributes"]?["rating"]
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
                            "${widget.resGifts?["data"]?[widget.index]?["attributes"]?["numOfReviews"] ?? ""} reviews",
                            style:
                                const TextStyle(fontSize: 10, color: greyColor),
                          )
                        ],
                      ),
                      GestureDetector(
                          onTap: () {
                            widget.onTapWhisList!();
                          },
                          child: widget.resGifts?["data"]?[widget.index]
                                      ?["attributes"]?["isWishlist"] ==
                                  1
                              ? const Icon(Icons.favorite, color: redColor)
                              : const Icon(Icons.favorite_border,
                                  color: greySolidColor))
                    ],
                  )
                ],
              ),
            ),
            if (widget.resGifts?["data"]?[widget.index]?["attributes"]
                    ?["isNew"] ==
                1)
              Container(
                  alignment: Alignment.topRight,
                  child: Image.asset("lib/assets/images/ic_new.png"))
          ],
        ));
  }
}
