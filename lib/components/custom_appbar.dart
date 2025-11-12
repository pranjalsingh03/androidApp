import 'package:flutter/material.dart';
import 'package:sheshya/components/app_bar_back_button.dart';
import 'package:sheshya/constants/styles.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  const CustomAppbar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const AppBarBackButton(),
      title: Text(title, style: kAppBarText),
    );
  }
}
