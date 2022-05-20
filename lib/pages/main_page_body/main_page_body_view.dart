import "package:flutter/material.dart";

import '../../constants/constants.dart';
import '../../constants/methods/methods.dart';

// import '../../widgets/random_letters_widget.dart';
import '../../widgets/widgets.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  late Map<LetterClass, List<dynamic>> saveIndexArray;
  late List<LetterClass> randomLetterList;
  late List<LetterClass> emptyStringList;

  @override
  void initState() {
    //Preparation data
    List<String> tempRandomLetterList =
        Constants.keyWords[0].toUpperCase().split('');

    tempRandomLetterList.addAll(Constants.alphabetList.where((elem) =>
        !tempRandomLetterList.contains(elem) &&
        tempRandomLetterList.length < 12));
    tempRandomLetterList.shuffle();

    List<String> tempEmptyStringList =
        List<String>.filled(Constants.keyWords[0].length, '');

    //Preparation LetterClass List
    saveIndexArray = {};

    randomLetterList = tempRandomLetterList
        .map((e) => LetterClass(
              letter: e,
              id: UniqueKey().toString(),
            ))
        .toList();

    emptyStringList = tempEmptyStringList
        .map((e) => LetterClass(
              letter: e,
              id: UniqueKey().toString(),
            ))
        .toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReplaceInherited(
      model: ReplaceModel(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double mh = constraints.maxHeight;
          double mw = constraints.maxWidth;

          ReplaceInherited.of(context).randomLetterList = randomLetterList;
          ReplaceInherited.of(context).emptyStringList = emptyStringList;
          ReplaceInherited.of(context).saveIndexArray = saveIndexArray;
          ReplaceInherited.of(context).keyWord = Constants.keyWords[0];

          return Container(
            height: mh,
            width: mw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: mw,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: giveW(size: 15, mw: mw),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: ReplaceInherited.of(context)
                            ._emptyStringList!
                            .map((e) => CustomWidget(
                                  mw: mw,
                                  mh: mh,
                                  letterElem: e,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),

                Container(
                  height: giveH(size: 79, mh: mh),
                  margin: EdgeInsets.only(bottom: giveH(size: 30, mh: mh), top: giveH(size: 30, mh: mh)),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        ReplaceInherited.of(context)._randomLetterList!.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6),
                    itemBuilder: (context, index) {
                      return CustomWidget(
                        mw: mw,
                        mh: mh,
                        letterElem: ReplaceInherited.of(context)
                            ._randomLetterList![index],
                      );
                    },
                  ),
                )

              ],
            ),
          );
        },
      ),
    );
  }
}

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

class ReplaceModel extends ChangeNotifier {
  String? _keyWord;
  List<LetterClass>? _randomLetterList;
  List<LetterClass>? _emptyStringList;
  Map<LetterClass, List<dynamic>>? _saveIndexArray;

  set keyWord(value) => _keyWord = value;

  set randomLetterList(value) => _randomLetterList = value;

  set emptyStringList(value) => _emptyStringList = value;

  set saveIndexArray(value) => _saveIndexArray = value;

  void replaceItems(LetterClass letterObject) {
    bool isNoNull = [
      _keyWord,
      _randomLetterList,
      _emptyStringList,
      _saveIndexArray
    ].every((element) => element != null);
    if (isNoNull) {
      //String _totalAnswer = _saveIndexArray!.keys.join();

      if (_emptyStringList!.every((element) => element.letter.isNotEmpty)) {
      } else {
        if (containsKeyExtend(
          letterClassObject: letterObject,
          letterMap: _saveIndexArray!,
        )) {
          List tempPositionList = valueExtend(
            letterMap: _saveIndexArray!,
            letterObject: letterObject,
          );

          int randomLetterIndex = tempPositionList[0];
          int emptyStringIndex = tempPositionList[1];

          LetterClass tempVar = _emptyStringList![randomLetterIndex];
          _emptyStringList![randomLetterIndex] =
              _randomLetterList![emptyStringIndex];
          _randomLetterList![emptyStringIndex] = tempVar;

          _saveIndexArray!.removeWhere(((key, value) {
            bool isExist =
                key.letter == letterObject.letter && key.id == letterObject.id;
            return isExist;
          }));
          notifyListeners();
        } else {
          int emptyStringIndex =
              _emptyStringList!.indexWhere((element) => element.letter.isEmpty);
          int randomLetterIndex = _randomLetterList!.indexWhere(
            (element) =>
                element.letter == letterObject.letter &&
                element.id == letterObject.id,
          );

          LetterClass tempVar = _emptyStringList![emptyStringIndex];
          _emptyStringList![emptyStringIndex] =
              _randomLetterList![randomLetterIndex];
          _randomLetterList![randomLetterIndex] = tempVar;

          Map<LetterClass, List<int>> tempMap = {
            letterObject: [emptyStringIndex, randomLetterIndex]
          };
          _saveIndexArray!.addEntries(tempMap.entries);
          notifyListeners();
        }
      }
    }
  }
}

class ReplaceInherited extends InheritedNotifier<ReplaceModel> {
  final ReplaceModel model;

  const ReplaceInherited({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);

  static ReplaceModel of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<ReplaceInherited>()!.model;
    return result;
  }
}

class LetterClass {
  final String letter;
  final String id;

  const LetterClass({required this.letter, required this.id});
}

// class CheckAndReplace {
//   String? keyWord;
//   List<String>? randomLetterList;
//   Map<String, List<dynamic>> saveIndexArray = {};
//   List<String>
//   void replaceElemFunc({required String letter}) {
//     if (placeHolderList.every((element) => element is String)) {
//     } else {
//       if (saveIndexArray.containsKey(letter)) {
//         int phElemIndex = saveIndexArray[letter]![0];
//         int lbElemIndex = saveIndexArray[letter]![1];
//         Widget tempVar = placeHolderList[phElemIndex];
//         placeHolderList[phElemIndex] = letterBoxList[lbElemIndex];
//         letterBoxList[lbElemIndex] = tempVar;
//         saveIndexArray.remove(letter);
//       } else {
//         () {
//           int phElemIndex = placeHolderList.indexOf(placeHolderList
//               .firstWhere((element) => element is CustomWidget));
//           int lbElemIndex = randomLetterList.indexOf(letter);
//           Widget tempVar = placeHolderList[phElemIndex];
//           placeHolderList[phElemIndex] = letterBoxList[lbElemIndex];
//           letterBoxList[lbElemIndex] = tempVar;
//           saveIndexArray.addEntries({
//             letter: [phElemIndex, lbElemIndex]
//           }.entries);
//         };
//       }
//     }
//   }
// }
