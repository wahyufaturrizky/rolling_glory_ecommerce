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
import 'package:rolling_glory_ecommerce/component/spinner.dart';
import 'package:rolling_glory_ecommerce/service/gifts/gifts.dart';

class MyHomePageApp extends StatelessWidget {
  const MyHomePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const pageSize = 8;
  var totalPages;
  var currentPageState = 0;
  int itemPerPageState = 0;
  var noDataAnymore = false;

  late ScrollController? gridViewContoller = ScrollController();

  bool isLoadingResGifts = false;
  var resGifts;

  @override
  void initState() {
    getDataGifts();

    gridViewContoller?.addListener(() {
      if (gridViewContoller!.position.atEdge) {
        bool isTop = gridViewContoller!.position.pixels == 0;
        if (isTop) {
          print('At the top');
        } else {
          print('At the bottom');
          getDataGifts(pageKey: currentPageState + 1);
        }
      }
    });

    super.initState();
  }

  Future<dynamic> getDataGifts({pageKey = 1}) async {
    if (!mounted) return;
    try {
      if (mounted) {
        setState(() {
          isLoadingResGifts = true;
        });
      }

      var queryParameters;

      queryParameters = {
        'page[number]': pageKey.toString(),
        'page[size]': pageSize.toString(),
      };

      var res = await handleGetDataGifts(queryParameters);

      if (res != null) {
        if (mounted) {
          if (res?["meta"]?["totalPages"] > currentPageState) {
            var response = {
              ...res,
              "data": [
                ...resGifts?["data"] ?? [],
                ...res?["data"],
              ]
            };
            print(response);

            int tempItemPerPageState = res?["data"]?.length;

            setState(() {
              resGifts = response;
              isLoadingResGifts = false;
              totalPages = res?["meta"]?["totalPages"];
              currentPageState = res?["meta"]?["currentPage"];
              itemPerPageState = itemPerPageState + tempItemPerPageState;
            });
          } else {
            setState(() {
              noDataAnymore = true;
              isLoadingResGifts = false;
            });
          }
        }
      }
    } on DioException catch (e) {
      if (mounted) {
        setState(() {
          isLoadingResGifts = false;
        });
      }

      print('Error getDataGifts = $e');
    }
  }

  @override
  void dispose() {
    gridViewContoller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: GridView.builder(
                        controller: gridViewContoller,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 21,
                                crossAxisSpacing: 21),
                        itemCount: itemPerPageState,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(216, 216, 216, 1),
                                    width: 1),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4),
                                )),
                            child: Column(
                              children: [
                                if (resGifts?["data"]?[index]?["attributes"]
                                        ?["images"] !=
                                    null)
                                  Image.network(
                                    resGifts?["data"]?[index]?["attributes"]
                                        ?["images"]?[0],
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                Text(
                                  resGifts?["data"]?[index]?["attributes"]
                                          ?["name"] ??
                                      "",
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      color: Color.fromRGBO(37, 49, 91, 1),
                                      fontSize: 12),
                                )
                              ],
                            ),
                          );
                        })),
                if (noDataAnymore)
                  const Center(
                    child: Text("👋🏻 Hi your reach the end of the list",
                        style: TextStyle(fontSize: 14)),
                  ),
                if (isLoadingResGifts) MySpinnerApp()
              ],
            )));
  }
}
