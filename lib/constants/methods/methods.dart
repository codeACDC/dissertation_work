import 'package:confetti/confetti.dart';
import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';

import '../../pages/main_page/drawer/exit_widget.dart';
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
}) {
  var answerBox = Hive.box(Constants.answerBox);

  var answerBoxValues = answerBox.values;
  bool boxElemExist = !answerBoxValues.any((elem) => elem.word == keyWord);

  debugPrint('Answer box elem don\'t exist? : ' + boxElemExist.toString());
  AnswerModel answerModel = AnswerModel(
    word: keyWord,
    isCorrectAnswer: true,
    imagesUrl: imagesUrl,
    totalList: totalList,
  );
  if (boxElemExist) {
    answerBox.add(answerModel);

    //remove duplicated data
    duplicatedDataRemover(answerBox);
  } else { 
    //get index of current answer model according to index
    var answerBoxList = answerBoxValues.toList();
    int indexOfAnswerModel = answerBoxList.indexOf(answerBoxValues.firstWhere(
        (element) => element.word == keyWord,
        orElse: () => answerModel));
    debugPrint('index of answer model: ' + indexOfAnswerModel.toString());
    //delete current answer model
    answerBoxList.removeWhere((element) {
      return element.word == keyWord;
    });
    //insert answer model with current index
    answerBoxList.insert(indexOfAnswerModel, answerModel);
    //delete all values
    answerBox.deleteAll(answerBox.keys);
    //add edited answer model list
    answerBox.addAll(answerBoxList);
  }
  //Emergency delete
  // answerBox.deleteAll(answerBox.keys);
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
  //Open fireBaseBox
  var fireBaseBoxValues = Hive.box(Constants.fireBaseBox).values;
  //add new length of keyWords
  changesBox.add(fireBaseBoxValues.length);
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

String nextKeyWord() {
  //Open keyWordBox
  var keyWordBox = Hive.box(Constants.keyWordBox);
  //Open fireBaseBox and get its values
  List fireBaseBoxValues = Hive.box(Constants.fireBaseBox).values.toList();
  //if keyWordBox length bigger or equal to the keyWordList length clear keyWordBox
  if (keyWordBox.length >= fireBaseBoxValues.length) {
    keyWordBox.deleteAll(keyWordBox.keys);
  }

  //get keyWord values
  List keyWordValues = keyWordBox.values.toList();

  //get list of data that doesn't contain in keyWordList
  List tempKeyWords = fireBaseBoxValues
      .where((element) => !keyWordValues.contains(element))
      .toList();

  //get first keyWord elem
  var firstKeyWord = tempKeyWords.first;

  // Emergency delete
  // keyWordBox.deleteAll(keyWordBox.keys);
  // var answerBox = Hive.box(Constants.answerBox);
  // answerBox.deleteAll(answerBox.keys);

  return firstKeyWord;
}

void addToKeyWordBoxWhenTrue({
  required String keyWord,
}) {
  //Open keyWord box
  var keyWordBox = Hive.box(Constants.keyWordBox);
  keyWordBox.add(keyWord);
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
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(giveH(size: 10, mh: mh)),
            topRight: Radius.circular(giveH(size: 10, mh: mh)),
          )),
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

Future<bool> onBackButtonPressed(BuildContext context,
    {List? translations}) async {
  bool? exitApp = await showDialog(
      context: context,
      builder: (context) {
        return const ExitWidget();
      });
  return exitApp ?? false;
}

Future<void> playSound(
    {required AudioPlayer audioPlayer, required bool? isCorrectAnswer}) async {
  if (isCorrectAnswer != null) {
    if (isCorrectAnswer) {
      await audioPlayer
          .setAsset(Constants.soundEffectsMap['correctSoundPath']!);
    } else {
      await audioPlayer
          .setAsset(Constants.soundEffectsMap['inCorrectSoundPath']!);
    }
    await audioPlayer.play();
  }
}

void doSoundMute(
    {required AudioPlayer audioPlayer, required bool isMute}) async {
  isMute ? await audioPlayer.setVolume(0.0) : await audioPlayer.setVolume(1);
}
