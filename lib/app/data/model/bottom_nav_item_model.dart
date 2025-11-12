import 'package:flutter/material.dart';

class BottomNavItemModel {
  final String assetPath;
  final Color color;
  final Color selectedColor;
  final String name;
  final int index;

  BottomNavItemModel({
    required this.assetPath,
    required this.color,
    required this.selectedColor,
    required this.name,
    required this.index,
  });
}
