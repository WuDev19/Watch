import 'package:flutter/material.dart';

class ExpandScrollText extends StatefulWidget {
  final String _movieSynopsis;

  const ExpandScrollText({super.key, required String movieSynopsis})
    : _movieSynopsis = movieSynopsis;

  @override
  State<ExpandScrollText> createState() => _ExpandScrollTextState();
}

class _ExpandScrollTextState extends State<ExpandScrollText> {
  bool isExpanded = false;
  bool isTriggered = false;
  double totalDrag = 0;

  void expandText(double distance) {
    if (isTriggered) return;
    isTriggered = true;
    Future.delayed(Duration(milliseconds: 300), () {
      if (distance > 2) {
        setState(() {
          isExpanded = true;
        });
      } else {
        setState(() {
          isExpanded = false;
        });
      }
      isTriggered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (_) {
        totalDrag = 0;
      },
      onVerticalDragUpdate: (details) {
        totalDrag += details.delta.dy;
        expandText(totalDrag);
      },
      child: AnimatedSize(
        alignment: AlignmentGeometry.topCenter,
        duration: const Duration(milliseconds: 500),
        reverseDuration: const Duration(milliseconds: 500),
        child: Text(
          widget._movieSynopsis,
          maxLines: isExpanded ? null : 3,
          overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
