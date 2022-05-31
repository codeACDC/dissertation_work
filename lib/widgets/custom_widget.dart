import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../constants/methods/methods.dart';
import 'models/letter_model.dart';
import 'replace_inherited_widget.dart';

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    Key? key,
    required this.mw,
    required this.mh,
    required this.letterElem,
  }) : super(key: key);

  final double mw;
  final double mh;
  final LetterModel letterElem;

  @override
  Widget build(BuildContext context) {
    var tempLetter = letterElem.letter;
    return tempLetter != ''
        ? StatefulBuilder(
          builder: (context,  setState) {
            return Material(
                color: Colors.white.withOpacity(0.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                      ReplaceInherited.of(context).replaceItems(letterElem);
                      ReplaceInherited.of(context).checkAnswer();
                      ReplaceInherited.of(context).changeAlign();
                  },
                  child: Container(
                    height:  giveW(size: 50, mw: mw),
                    width: giveW(size: 50, mw: mw),
                    margin: EdgeInsets.symmetric(
                      horizontal: giveW(size: 4, mw: mw),
                      vertical: giveH(size: 2, mh: mh),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.circular(giveH(size: 6, mh: mh))),
                    child: flexTextWidget(
                      fontSize: giveH(size: 16, mh: mh),
                      text: tempLetter,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
          }
        )
        : Container(
            width: giveW(size: 50, mw: mw),
            height: giveW(size: 50, mw: mw),
            margin: EdgeInsets.symmetric(
                vertical: giveH(size: 2, mh: mh),
                horizontal: giveW(size: 4, mw: mw)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(giveH(size: 6, mh: mh)),
            ),
          );
  }
}