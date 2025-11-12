import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: const Icon(
        size: 34,
        Icons.chevron_left,
      ),
    );
  }
}
