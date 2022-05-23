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
  final LetterClass letterElem;

  @override
  Widget build(BuildContext context) {
    var tempLetter = letterElem.letter;
    return tempLetter != ''
        ? Container(
      height: giveW(size: 50, mw: mw),
      width: giveW(size: 50, mw: mw),
      margin: EdgeInsets.symmetric(
        horizontal: giveW(size: 4, mw: mw),
        vertical: giveH(size: 2, mh: mh),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          primary: Colors.amber,
          elevation: 5,
        ),
        onPressed: () {
          ReplaceInherited.of(context).replaceItems(letterElem);
        },
        child: flexTextWidget(
          fontSize: giveH(size: 16, mh: mh),
          text: tempLetter,
          fontWeight: FontWeight.w600,
        ),
      ),
    )
        : Container(
      width: giveW(size: 50, mw: mw),
      height: giveW(size: 50, mw: mw),
      margin: EdgeInsets.symmetric(
          vertical: giveH(size: 2, mh: mh),
          horizontal: giveW(size: 4, mw: mw)),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

