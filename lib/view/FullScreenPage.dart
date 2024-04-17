// views/full_screen_image.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../model/Model.dart';

class FullScreenImagePage extends StatelessWidget {
  final ImageModel imageModel;

  FullScreenImagePage(this.imageModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(title: const Text('Full Screen Image')),
      body: Center(
        child: Hero(
          tag: imageModel.imageUrl, // Same Hero tag as in ImageItem
          child: CachedNetworkImage(
            imageUrl: imageModel.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
