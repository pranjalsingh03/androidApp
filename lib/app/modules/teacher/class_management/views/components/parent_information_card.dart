import 'package:flutter/material.dart';
import 'package:sheshya/app/modules/teacher/class_management/views/components/table_row_text.dart';
import 'package:sheshya/constants/dimensions.dart';
import 'package:sheshya/constants/styles.dart';
import 'package:sheshya/constants/ui_constants.dart';

class ParentInformationCard extends StatelessWidget {
  const ParentInformationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Dimensions.defaultPadding),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parent Information',
            style: kDark_16_600,
          ),
          k16YGap,
          const TableRowText(
            cat: 'Father Name',
            value: 'Akaxx Anand',
          ),
          kDivider,
          const TableRowText(
            cat: 'Contact',
            value: '6257xxxxxx',
          ),
          kDivider,
          const TableRowText(
            cat: 'Mothers Name',
            value: 'Akshixx Anand',
          ),
          kDivider,
          const TableRowText(
            cat: 'Contact',
            value: '6257xxxxxx ',
          ),
          kDivider,
          const TableRowText(
            cat: 'Occupation',
            value: 'Job | Business',
          ),
        ],
      ),
    );
  }
}
