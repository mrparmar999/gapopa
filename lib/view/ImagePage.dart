// views/image_item.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
  import 'package:shimmer/shimmer.dart';

import '../model/Model.dart';
import 'FullScreenPage.dart';

class ImagePage extends StatelessWidget {
  final ImageModel imageModel;

  ImagePage(this.imageModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(FullScreenImagePage(imageModel) );

      },
      child: Card(
        elevation: 2.0,
        child: Stack(
          children: [
            Hero(
              tag:imageModel.imageUrl,
              child: CachedNetworkImage(
                imageUrl: imageModel.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: _buildImagePlaceholder()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),

            _buildImageDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return SizedBox(
      width: double.infinity,
      height: 200.0, // Adjust the height as needed
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildImageDetails() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Likes: ${imageModel.likes}',
              style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'Views: ${imageModel.views}',
              style:const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
