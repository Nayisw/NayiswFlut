import 'package:flutter/material.dart';

class SquareTileBox extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTileBox({super.key, required this.imagePath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey.shade200),
        child: Image.asset(imagePath, height: 50),
      ),
    );
  }
}
