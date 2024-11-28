import 'package:flutter/material.dart';
import 'package:gapopa1/view/homePage.dart';
import 'package:get/get.dart';

import 'controller/homepageController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}

