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
import 'package:rolling_glory_ecommerce/component/card.dart';
import 'package:rolling_glory_ecommerce/component/spinner.dart';
import 'package:rolling_glory_ecommerce/screen/detail_screen.dart';
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
  bool isLoadingWhistList = false;
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

  Future<dynamic> handleWhistList({idGift, context, isWishlist}) async {
    try {
      setState(() {
        isLoadingWhistList = true;
      });

      var res = await handleWhislistGifts(idGift);

      if (res != null) {
        var snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: Duration(milliseconds: 2000),
            content: Text(
              isWishlist == 0
                  ? "⛹️ Success add favorite"
                  : "❌ Success remove favorite",
            ));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          isLoadingWhistList = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoadingWhistList = false;
      });
    }
  }

  @override
  void dispose() {
    gridViewContoller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext mainContext) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                    child: GridView.builder(
                        controller: gridViewContoller,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 21,
                            mainAxisExtent:
                                MediaQuery.of(mainContext).size.height * 0.43,
                            crossAxisSpacing: 21),
                        itemCount: itemPerPageState,
                        itemBuilder: (BuildContext context, int index) {
                          return MyCardApp(
                            index: index,
                            resGifts: resGifts,
                            onTap: () {
                              Navigator.push(
                                  mainContext,
                                  MaterialPageRoute(
                                      builder: (context) => MyDetailPageApp(
                                          detailData: resGifts?["data"]
                                              ?[index])));
                            },
                            onTapWhisList: () {
                              if (!isLoadingWhistList) {
                                handleWhistList(
                                    idGift: resGifts?["data"]?[index]?["id"],
                                    context: mainContext,
                                    isWishlist: resGifts?["data"]?[index]
                                        ?["attributes"]?["isWishlist"]);
                              }
                            },
                          );
                        })),
                if (noDataAnymore)
                  const Center(
                    child: Text("👋🏻 Hi your reach the end of the list",
                        style: TextStyle(fontSize: 14)),
                  ),
                if (isLoadingResGifts) const MySpinnerApp()
              ],
            )));
  }
}
