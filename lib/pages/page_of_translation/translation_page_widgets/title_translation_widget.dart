import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/methods/methods.dart';
import '../../../widgets/widgets.dart';

class TitleTranslationWidget extends StatelessWidget {
  const TitleTranslationWidget({
    Key? key,
    required this.mh,
    required this.mw,
    required this.translationMap,
  }) : super(key: key);

  final double mh;
  final double mw;
  final Map<String, dynamic> translationMap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: giveH(size: 16, mh: mh),
      width: mw,
      margin: EdgeInsets.only(bottom: giveH(size: 5, mh: mh)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            translationMap.containsKey('text')
                ? flexTextWidget(
                boxFit: BoxFit.contain,
                text: translationMap['text'],
                color: ConstColor.translationText,
                fontSize: giveH(size: 16, mh: mh))
                : const SizedBox(),
            translationMap.containsKey('ts')
                ? flexTextWidget(
                boxFit: BoxFit.contain,
                text: ' [${translationMap['ts']}] ',
                color: ConstColor.translationText,
                fontSize: giveH(size: 16, mh: mh))
                : const SizedBox(),
            translationMap.containsKey('pos')
                ? flexTextWidget(
                boxFit: BoxFit.contain,
                text: ' /${translationMap['pos']}/ ',
                color: ConstColor.translationText,
                fontSize: giveH(size: 16, mh: mh))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
