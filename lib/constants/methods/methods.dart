
import 'package:confetti/confetti.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../pages/page_of_translation/translation_page.dart';
import '../../widgets/models/letter_model.dart';

double giveH({
  required double size,
  required double mh,
}) {
  return (size / 393) * mh;
}

double giveW({
  required double size,
  required double mw,
}) {
  return (size / 393) * mw;
}

bool containsKeyExtend({
  required LetterModel letterClassObject,
  required Map<LetterModel, List<dynamic>> letterMap,
}) {
  bool isEqual = letterMap.keys.toList().any((element) {
    return element.letter == letterClassObject.letter &&
        element.id == letterClassObject.id;
  });
  if (isEqual) {
    return true;
  } else {
    return false;
  }
}

dynamic valueExtend({
  required Map<LetterModel, List<dynamic>> letterMap,
  required LetterModel letterObject,
}) {
  List<LetterModel> letterKeys = letterMap.keys.toList();
  List<dynamic> letterValues = letterMap.values.toList();

  int valueIndex = letterKeys.indexWhere((element) {
    return element.id == letterObject.id &&
        element.letter == letterObject.letter;
  });

  return letterValues[valueIndex];
}

Color answerColor(bool? answer) {
  if (answer == null) {
    return Colors.white.withOpacity(0.0);
  } else {
    Color tempColor =
        answer ? Colors.green.withOpacity(0.6) : Colors.red.withOpacity(0.6);
    return tempColor;
  }
}

void showCongratulation({
  required bool? isCorrect,
  required BuildContext context,
  required double mh,
  required double mw,
  required String keyWord,
  required ConfettiController confettiController,
}) {
  if (isCorrect == true) {
    Future.delayed(
      Duration.zero,
      () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh))),
          content:  Builder(
            builder: (context) {
              confettiController.play();
              return SizedBox(
                      height: giveH(size: 50, mh: mh),
                      child: flexTextWidget(
                          text: 'Правильно!', fontSize: giveH(size: 20, mh: mh), color: Colors.white));
            }
          ),onVisible: (){
            Future.delayed(const Duration(milliseconds: 2800),() {
              Navigator.of(context).pushReplacementNamed(TranslationPage.id, arguments: keyWord);
            },);
        },
          duration: const Duration(seconds: 2),
          dismissDirection: DismissDirection.none,
          backgroundColor: Colors.deepPurple[800],
          elevation: giveW(size: 5, mw: mw),
        ));
      },
    );
  }
}
