/*
 * Rolling Glory Mobile App
 * Created by Wahyu Fatur Rizki
 * https://www.linkedin.com/in/wahyu-fatur-rizky/
 * 
 * Copyright (c) 2024 Wahyu Fatur Rizki, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class MyDetailPageApp extends StatelessWidget {
  const MyDetailPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyDetailPage();
  }
}

class MyDetailPage extends StatefulWidget {
  const MyDetailPage({super.key});

  @override
  State<MyDetailPage> createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                'Detail',
              ),
            )
          ],
        ),
      ),
    );
  }
}
