/*
 * Rolling Glory Mobile App
 * Created by Wahyu Fatur Rizki
 * https://www.linkedin.com/in/wahyu-fatur-rizky/
 * 
 * Copyright (c) 2024 Wahyu Fatur Rizki, LLC. All rights reserved.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/material.dart';

class MySpinnerApp extends StatelessWidget {
  const MySpinnerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MySpinner();
  }
}

class MySpinner extends StatefulWidget {
  const MySpinner({super.key});

  @override
  State<MySpinner> createState() => _MySpinnerState();
}

class _MySpinnerState extends State<MySpinner> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return const Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
