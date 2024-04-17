// views/image_grid.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/Controller.dart';
import 'ImagePage.dart';

class HomePage extends StatelessWidget {
  final ImageController imageController = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Gallery')),
      body: Obx(
            () => imageController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: calculateCrossAxisCount(context),
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0
          ),
          itemCount: imageController.images.length,
          itemBuilder: (context, index) {
            return ImagePage(imageController.images[index]);
          },
        ),
      ),
    );
  }

  int calculateCrossAxisCount(BuildContext context) {
    // Calculate the number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = 150.0; // Adjust this value according to your design
    final crossAxisCount = (screenWidth / itemWidth).floor();
    return crossAxisCount > 0 ? crossAxisCount : 1;
  }
}
