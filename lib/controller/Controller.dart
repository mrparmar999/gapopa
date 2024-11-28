 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class DockController extends GetxController {
  // List of icons in the dock
  RxList<IconData> dockItems = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ].obs;

  // Dragging and hovered states
  Rx<IconData?> Icon = Rx<IconData?>(null);
  RxInt hoveredIndex = RxInt(-1);
  RxInt size = RxInt(-1);

  // Handle reordering logic
  void reorder(int oldIndex, int newIndex) {
    if (oldIndex != newIndex) {
      final icon = dockItems.removeAt(oldIndex);
      dockItems.insert(newIndex, icon);
    }
  }
}
