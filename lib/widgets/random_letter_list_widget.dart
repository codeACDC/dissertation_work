import 'package:flutter/material.dart';

import '../constants/methods/methods.dart';
import 'custom_widget.dart';
import 'replace_inherited_widget.dart';

class RandomLetterListWidget extends StatelessWidget {
  const RandomLetterListWidget({
    Key? key,
    required this.mh,
    required this.mw,
  }) : super(key: key);

  final double mh;
  final double mw;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: giveH(size: 79, mh: mh),
      margin: EdgeInsets.symmetric(
          vertical: giveH(size: 10, mh: mh)),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (ReplaceInherited.of(context)
            .randomLetterList ?? [])
            .length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6),
        itemBuilder: (context, index) {
          return CustomWidget(
            mw: mw,
            mh: mh,
            letterElem: ReplaceInherited.of(context)
                .randomLetterList![index],
          );
        },
      ),
    );
  }
}
