 

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../controller/homepageController.dart';

class HomePage extends StatelessWidget {
  final DockController controller = Get.put(DockController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Obx(() => Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          controller.dockItems.length,
              (index) => buildDrag(controller.dockItems[index], index),
        ),
      )),
    );
  }

  Widget buildDrag(IconData icon, int index) {
    return MouseRegion(
      onEnter: (_) {
        controller.hoveredIndex.value = index; // Update hovered index
      },
      onExit: (_) {
        controller.hoveredIndex.value = -1; // Reset hovered index when mouse exits
      },
      child: Draggable<IconData>(
        data: icon,
        onDragStarted: () {
          controller.Icon.value = icon; // Set the dragged icon
        },
        onDragUpdate: (_) {
          print('update: ${_.localPosition}');
        },
        onDragCompleted: () {
          print('complete');
        },
        onDragEnd: (_) {
          controller.Icon.value = null; // Reset dragging state after drag ends
        },
        feedback: Transform.scale(
          scale: 1.1,
          child: buildButton(icon, isDragging: true),
        ),
        childWhenDragging: const SizedBox.shrink(),
        child: DragTarget<IconData>(
          onAccept: (data) {
            final indexes = controller.dockItems.indexOf(data);
            controller.reorder(indexes, index);
          },
          builder: (context, candidateData, rejectedData) {
            return Row(
              children: [
                if (controller.Icon.value != null && controller.hoveredIndex.value == index)
                  const SizedBox(width: 50), // Show a space when both conditions are true

                buildButton(icon),
                // Add a SizedBox when dragging and hovering
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildButton(IconData icon, {bool isDragging = false}) {
    final index = controller.dockItems.indexOf(icon); // Get the index of the icon

    return Obx(() {
      final width = controller.size.value == index ? 50.0 : 48.0; // Dynamically adjust width based on hover/drag
      final scale = controller.hoveredIndex.value == index ? 1.2 : 1.0; // Increase size when hovered

      return AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        child: Container(
          margin: const EdgeInsets.all(8),
          constraints: BoxConstraints(minWidth: width, minHeight: 48),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isDragging
                ? [
              BoxShadow(
                color: Colors.black45,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ]
                : [],
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      );
    });
  }
}
