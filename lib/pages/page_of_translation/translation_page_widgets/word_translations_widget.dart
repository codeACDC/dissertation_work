import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import '../../../constants/methods/methods.dart';
import '../../../widgets/widgets.dart';

class WordTranslationsWidget extends StatelessWidget {
  const WordTranslationsWidget({
    Key? key,
    required this.mw,
    required this.mh,
    required this.translationList,
  }) : super(key: key);

  final double mw;
  final double mh;
  final  dynamic translationList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mw,
      margin: EdgeInsets.symmetric(vertical: giveH(size: 5, mh: mh)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          flexTextWidget(
            text: 'Переводы:',
            fontSize: 14,
            color: Colors.white,
          ),
          Expanded(
              child: Wrap(
                alignment: WrapAlignment.end,
                runSpacing: giveW(size: 5, mw: mw),
                spacing: giveW(size: 5, mw: mw),
                children: [
                  ...translationList.map((e) => Container(
                      height: giveH(size: 16, mh: mh),
                      child: Padding(
                        padding: EdgeInsets.all(giveH(size: 2, mh: mh)),
                        child: flexTextWidget(
                          boxFit: BoxFit.contain,
                          text: e['text'],
                          fontSize: giveH(size: 11, mh: mh),
                          color: ConstColor.translationText,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: ConstColor.translationContainerBG,
                        borderRadius: BorderRadius.circular(
                            giveH(size: 20, mh: mh)),
                      )))
                ],
              ))
        ],
      ),
    );
  }
}

