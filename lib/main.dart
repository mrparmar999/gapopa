import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Dock(
            items: const [
              Icons.person,
              Icons.message,
              Icons.call,
              Icons.camera,
              Icons.photo,
            ],
          ),
        ),
      ),
    );
  }
}

class Dock extends StatefulWidget {
  const Dock({super.key, required this.items});
  final List<IconData> items;

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  late List<IconData> dockItems;
  IconData? draggingIcon;
  int? hoveredIndex; // Track the hovered item index

  @override
  void initState() {
    super.initState();
    dockItems = List.from(widget.items);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      final icon = dockItems.removeAt(oldIndex);
      dockItems.insert(newIndex, icon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          dockItems.length,
          (index) => _buildDraggableItem(dockItems[index], index),
        ),
      ),
    );
  }

  Widget _buildDraggableItem(IconData icon, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => hoveredIndex = index),
      onExit: (_) => setState(() => hoveredIndex = null),
      child: Draggable<IconData>(
        data: icon,
        onDragStarted: () => setState(() => draggingIcon = icon),
        onDragEnd: (_) => setState(() => draggingIcon = null),
        feedback: Transform.scale(
          scale: 1.5,
          child: _dockButton(icon, isDragging: true),
        ),
        childWhenDragging: const SizedBox.shrink(),
        child: DragTarget<IconData>(
          onMove: (details) {
            final data = details.data;
            if (data != icon) {
              final oldIndex = dockItems.indexOf(data);
              _onReorder(oldIndex, index);
            }
          },
          builder: (context, candidateData, rejectedData) {
            return AnimatedScale(
              scale: hoveredIndex == index || draggingIcon == icon ? 1.2 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: _dockButton(icon),
            );
          },
        ),
      ),
    );
  }

  Widget _dockButton(IconData icon, {bool isDragging = false}) {
    return Container(
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
      decoration: BoxDecoration(
        color: Colors.primaries[icon.hashCode % Colors.primaries.length],
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
    );
  }
}  
