import 'package:flutter/material.dart';

class ImageInsideCircles extends StatelessWidget {
  final Color circleColor;
  final Widget centerImage;

  const ImageInsideCircles({
    super.key,
    required this.circleColor,
    required this.centerImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer Circle
        Container(
          width: 234,
          height: 234,
          decoration: BoxDecoration(
            color: circleColor.withAlpha(20),
            shape: BoxShape.circle,
          ),
        ),
        // Middle Circle
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            color: circleColor.withAlpha(30),
            shape: BoxShape.circle,
          ),
        ),
        // Inner Circle
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: circleColor.withAlpha(35),
            shape: BoxShape.circle,
          ),
        ),
        // Center Image
        centerImage,
      ],
    );
  }
}
