import 'package:flutter/material.dart';

import '../../constants/methods/methods.dart';
import 'image_model.dart';
import 'letter_model.dart';

class ReplaceModel extends ChangeNotifier {
  List<String>? imagesUrl;
  List<LetterModel>? randomLetterList;
  List<LetterModel>? emptyStringList;
  Map<LetterModel, List<dynamic>>? saveIndexArray;
  List<Widget>? stackChildrenList;
  CorrectAnswerModel? correctAnswerModel;
  Alignment? inCorrectAnswerAlign;

  //empty string list align change func

  void changeAlign() {
    // bool isNoNull = [
    //   correctAnswerModel,
    // ].every((e) => e != null);

          if(correctAnswerModel!.isCorrect == false) {
            inCorrectAnswerAlign = Alignment.centerRight;
            notifyListeners();

            Future.delayed(const Duration(milliseconds: 100), () {

              inCorrectAnswerAlign = Alignment.centerLeft;
              notifyListeners();
            },);
          }
          Future.delayed(const Duration(milliseconds: 300),() {
            inCorrectAnswerAlign = null;
            notifyListeners();

          },);




  }

  // replace func for stack children
  void replaceStackChildren(ImageModel item) {
    if (stackChildrenList != null) {
      Widget temp;
      if (item.isTap) {
        Future.delayed(
          const Duration(milliseconds: 100),
          () {
            temp = stackChildrenList!.last;
            stackChildrenList!.last = stackChildrenList![item.index];
            stackChildrenList![item.index] = temp;
          },
        );
        item.isTap = false;
        notifyListeners();
      } else {
        temp = stackChildrenList!.last;
        stackChildrenList!.last = stackChildrenList![item.index];
        stackChildrenList![item.index] = temp;
        item.isTap = true;
        notifyListeners();
      }
    }
  }

// check for correct answer
  void checkAnswer() {
    bool isNoNull = [
      randomLetterList,
      emptyStringList,
      saveIndexArray,
      correctAnswerModel,
    ].every((element) => element != null);
    if (isNoNull && emptyStringList!.every((e) => e.letter.isNotEmpty)) {
      String enterAnswer = emptyStringList!
          .map((e) {
            return e.letter;
          })
          .join()
          .toLowerCase()
          .trim();
      String correctAnswer = correctAnswerModel!.correctAnswer;

      if (correctAnswer == enterAnswer) {
        correctAnswerModel!.isCorrect = true;
        notifyListeners();
      } else {

        correctAnswerModel!.isCorrect = false;
        notifyListeners();
      }
    }
    Future.delayed(
      const Duration(milliseconds: 300),
      () {
        correctAnswerModel!.isCorrect = null;
        notifyListeners();
      },
    );
  }

// replace func for letters
  void replaceItems(LetterModel letterObject) {
    bool isNoNull = [
      randomLetterList,
      emptyStringList,
      saveIndexArray,
      correctAnswerModel,
    ].every((element) => element != null);
    if (isNoNull) {
      if (containsKeyExtend(
        letterClassObject: letterObject,
        letterMap: saveIndexArray!,
      )) {
        List tempPositionList = valueExtend(
          letterMap: saveIndexArray!,
          letterObject: letterObject,
        );

        int randomLetterIndex = tempPositionList[0];
        int emptyStringIndex = tempPositionList[1];

        LetterModel tempVar = emptyStringList![randomLetterIndex];
        emptyStringList![randomLetterIndex] =
            randomLetterList![emptyStringIndex];
        randomLetterList![emptyStringIndex] = tempVar;

        saveIndexArray!.removeWhere(((key, value) {
          bool isExist =
              key.letter == letterObject.letter && key.id == letterObject.id;
          return isExist;
        }));

        notifyListeners();
      } else {
        int emptyStringIndex =
            emptyStringList!.indexWhere((element) => element.letter.isEmpty);
        int randomLetterIndex = randomLetterList!.indexWhere(
          (element) =>
              element.letter == letterObject.letter &&
              element.id == letterObject.id,
        );

        LetterModel tempVar = emptyStringList![emptyStringIndex];
        emptyStringList![emptyStringIndex] =
            randomLetterList![randomLetterIndex];
        randomLetterList![randomLetterIndex] = tempVar;

        Map<LetterModel, List<int>> tempMap = {
          letterObject: [emptyStringIndex, randomLetterIndex]
        };
        saveIndexArray!.addEntries(tempMap.entries);
        notifyListeners();
      }
    }
  }
}
