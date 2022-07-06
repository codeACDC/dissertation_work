import 'package:confetti/confetti.dart';
import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../pages/page_of_translation/translation_page.dart';
import '../../widgets/models/answer_model.dart';
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

void addNewAnswerModel({
  required String keyWord,
  required List totalList,
  required List imagesUrl,
  List exampleList = const [],
  List synonymsList = const [],
  List translationList = const [],
}) {
  var answerBox = Hive.box(Constants.answerBox);

  if (!answerBox.values.any((elem) => elem.word == keyWord)) {
    answerBox.add(AnswerModel(
      word: keyWord,
      isCorrectAnswer: true,
      examples: exampleList,
      imagesUrl: imagesUrl,
      synonyms: synonymsList,
      translates: translationList,
      totalList: totalList,
    ));
  }
  //Emergency delete
  // answerBox.deleteAll(answerBox.keys);

  //remove duplicated data
  duplicatedDataRemover(answerBox);
}

void duplicatedDataRemover(Box<dynamic> answerBox) {
  List answerBoxValues = answerBox.values.toList();
  List<AnswerModel> answerModelList = [];
  if (answerBoxValues.isNotEmpty) {
    for (var element in answerBoxValues) {
      if (!isDataExist(model: element, modelList: answerModelList)) {
        answerModelList.add(element);
      }
    }
    answerBox.deleteAll(answerBox.keys);
    answerBox.addAll(answerModelList);
  }
  debugPrint(
      'answer box elem\'s: ' + answerBoxValues.map((e) => e.word).toString());
}

bool isDataExist(
    {required AnswerModel model, required List<AnswerModel> modelList}) {
  bool isExist = modelList.any((element) => element.word == model.word);
  return isExist;
}

void detectChanges() {
  //Open changes box
  var changesBox = Hive.box(Constants.saveChangeBox);
  //add new length of keyWords
  changesBox.add(Constants.keyWords.length);
  //check if length bigger than one
  if (changesBox.length > 1) {
    //create new list of values
    List changesValues = changesBox.values.toList();
    //create new var that is the last element from the list
    var lastElem = changesValues.last;
    //create new var that is the before last element from the list
    var beforeLast = changesValues.elementAt(changesValues.length - 2);
    //check if previous elem fewer than next elem
    if (lastElem > beforeLast) {
      //open answer box
      var answerBox = Hive.box(Constants.answerBox);
      //get list of values
      List answerValues = answerBox.values.toList();
      //remove word 'whale' if it is in the list
      answerValues.removeWhere((e) => e.word == 'whale');
      //take unraveled words from answer box
      List unraveledWords = answerValues.map((e) => e.word).toList();
      //open keyWordBox
      var keyWordBox = Hive.box(Constants.keyWordBox);
      //clear all values from keyWordBox
      keyWordBox.deleteAll(keyWordBox.keys);
      //add unraveled words in keyWordBox
      keyWordBox.addAll(unraveledWords);
    }
  }
}

String nextKeyWord({
  required List<String> keyWordList,
}) {
  //Open keyWordBox
  var keyWordBox = Hive.box(Constants.keyWordBox);

  //if keyWordBox length bigger or equal to the keyWordList length clear keyWordBox
  if (keyWordBox.length >= keyWordList.length) {
    keyWordBox.deleteAll(keyWordBox.keys);
  }

  //get keyWord values
  List keyWordValues = keyWordBox.values.toList();
  print(keyWordValues);

  //get list of data that doesn't contain in keyWordList
  List<String> tempKeyWords =
      keyWordList.where((element) => !keyWordValues.contains(element)).toList();

  print(tempKeyWords);

  //get first keyWord elem
  var firstKeyWord = tempKeyWords.first;

  // Emergency delete
  // keyWordBox.deleteAll(keyWordBox.keys);

  return firstKeyWord;
}

void addToKeyWordBoxWhenTrue({
  required bool? isAnswerCorrect,
  required String keyWord,
}) {
  if(isAnswerCorrect != null) {
    if (isAnswerCorrect) {
      //Open keyWord box
      var keyWordBox = Hive.box(Constants.keyWordBox);
      keyWordBox.add(keyWord);
    }
  }
}

void showCongratulation({
  required bool? isCorrect,
  required BuildContext context,
  required double mh,
  required double mw,
  required String keyWord,
  required List<String> imagesUrl,
  required ConfettiController confettiController,
}) {
  if (isCorrect == true) {
    Future.delayed(
      Duration.zero,
      () {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh))),
          content: Builder(builder: (context) {
            confettiController.play();
            return SizedBox(
                height: giveH(size: 50, mh: mh),
                child: flexTextWidget(
                    text: 'Правильно!',
                    fontSize: giveH(size: 20, mh: mh),
                    color: Colors.white));
          }),
          onVisible: () {
            Future.delayed(
              const Duration(milliseconds: 2800),
              () {
                Navigator.of(context).pushReplacementNamed(TranslationPage.id,
                    arguments: [keyWord, imagesUrl]);
              },
            );
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
