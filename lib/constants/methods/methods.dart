
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
  required LetterClass letterClassObject,
  required Map<LetterClass, List<dynamic>> letterMap,
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

dynamic valueExtend({ required Map<LetterClass, List<dynamic>> letterMap,
  required LetterClass letterObject,}){
  List<LetterClass> letterKeys = letterMap.keys.toList();
  List<dynamic> letterValues = letterMap.values.toList();

  int valueIndex = letterKeys.indexWhere((element){
    return element.id == letterObject.id && element.letter == letterObject.letter;
  });

  return letterValues[valueIndex];

}

