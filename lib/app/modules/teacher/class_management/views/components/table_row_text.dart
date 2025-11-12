import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheshya/constant.dart';

class TableRowText extends StatelessWidget {
  const TableRowText({super.key, required this.cat, required this.value});

  final String cat;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$cat |',
          style: darknormal12,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Text(
            value,
            style: darksemibold12,
            maxLines: 2,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
