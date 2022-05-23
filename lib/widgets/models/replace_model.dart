
import 'package:flutter/material.dart';

import '../../constants/methods/methods.dart';
import 'letter_model.dart';

class ReplaceModel extends ChangeNotifier {
  String? keyWord;
  List<LetterClass>? randomLetterList;
  List<LetterClass>? emptyStringList;
  Map<LetterClass, List<dynamic>>? saveIndexArray;

  set keyWordSetter(value) => keyWord = value;

  set randomLetterListSetter(value) => randomLetterList = value;

  set emptyStringListSetter(value) => emptyStringList = value;

  set saveIndexArraySetter(value) => saveIndexArray = value;

  void replaceItems(LetterClass letterObject) {
    bool isNoNull = [
      keyWord,
      randomLetterList,
      emptyStringList,
      saveIndexArray
    ].every((element) => element != null);
    if (isNoNull) {
      //String _totalAnswer = _saveIndexArray!.keys.join();

      if (emptyStringList!.every((element) => element.letter.isNotEmpty)) {
      } else {
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

          LetterClass tempVar = emptyStringList![randomLetterIndex];
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

          LetterClass tempVar = emptyStringList![emptyStringIndex];
          emptyStringList![emptyStringIndex] =
          randomLetterList![randomLetterIndex];
          randomLetterList![randomLetterIndex] = tempVar;

          Map<LetterClass, List<int>> tempMap = {
            letterObject: [emptyStringIndex, randomLetterIndex]
          };
          saveIndexArray!.addEntries(tempMap.entries);
          notifyListeners();
        }
      }
    }
  }
}


