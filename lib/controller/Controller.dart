// controllers/image_controller.dart
import 'package:get/get.dart';
import '../model/Model.dart';
import '../service/config.dart';

class ImageController extends GetxController {
  var isLoading = true.obs;
  var images = <ImageModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  void fetchImages() async {
    try {
      isLoading(true);
      var fetchedImages = await ApiService.fetchImages(); // Implement this method
      images.assignAll(fetchedImages);
        } finally {
      isLoading(false);
    }
  }
}