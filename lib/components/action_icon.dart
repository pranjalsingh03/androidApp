import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionIcon extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  final IconData? iconData;
  const ActionIcon(
      {super.key, required this.icon, required this.onTap, this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: iconData != null ? Icon(iconData) : SvgPicture.asset(icon),
    );
  }
}
