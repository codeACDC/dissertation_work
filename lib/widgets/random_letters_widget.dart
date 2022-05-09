import 'package:flutter/material.dart';

import '../constants/methods/methods.dart';
import '../../widgets/widgets.dart';

class RandomLettersWidget extends StatelessWidget {
  const RandomLettersWidget({
    Key? key,
    required this.mw,
    required this.randomLettersList,
    required this.mh,
    required this.keyWord,
  }) : super(key: key);

  final double mw;
  final List<String> randomLettersList;
  final double mh;
  final String keyWord;

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        List<int> selectedLettersList = [];
        List<Widget> letterBoxList = randomLettersList.map(
              (letter) {
            return SizedBox(
              height: giveW(size: 50, mw: mw),
              width: giveW(size: 50, mw: mw),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  elevation: 5,
                ),
                onPressed: () {
                  setState((){
                    if(selectedLettersList.length != keyWord.length) {
                      selectedLettersList.add(randomLettersList.indexOf(letter),);
                    }
                  });
                  },
                child: flexTextWidget(
                  fontSize: giveH(size: 16, mh: mh),
                  text: letter,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ).toList();


        return Padding(
          padding: EdgeInsets.symmetric(vertical: giveW(size: 75, mw: mw)),
          child: Wrap(
            runSpacing: giveW(size: 12, mw: mw),
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: giveW(size: 8, mw: mw),
            children: letterBoxList,
          ),
        );
      },
    );
  }
}
