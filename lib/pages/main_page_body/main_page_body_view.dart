import "package:flutter/material.dart";

import '../../constants/constants.dart';
import '../../constants/methods/methods.dart';

// import '../../widgets/random_letters_widget.dart';
import '../../widgets/widgets.dart';

class MainPageBody extends StatelessWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double mh = constraints.maxHeight;
        double mw = constraints.maxWidth;

        Map<String, List<dynamic>> saveIndexArray = {};

        List<String> randomLetterList =
            Constants.keyWords[0].toUpperCase().split('');

        randomLetterList.addAll(Constants.alphabetList.where((elem) =>
            !randomLetterList.contains(elem) && randomLetterList.length < 12));
        randomLetterList.shuffle();


        List<String> emptyStringList =
        List<String>.filled(Constants.keyWords[0].length, '');

        ReplaceInherited.of(context).randomLetterList = randomLetterList;
        ReplaceInherited.of(context).emptyStringList = emptyStringList;
        ReplaceInherited.of(context).saveIndexArray = saveIndexArray;
        ReplaceInherited.of(context).keyWord = Constants.keyWords[0];
        
        final model = ReplaceModel();

        return Container(
          height: mh,
          width: mw,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: ReplaceInherited(
            model: model,
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
                        children: emptyStringList
                            .map((e) => CustomWidget(
                                  mw: mw,
                                  mh: mh,
                                  letter: e,
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: giveW(size: 75, mw: mw)),
                  child: Wrap(
                      runSpacing: giveW(size: 12, mw: mw),
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: giveW(size: 8, mw: mw),
                      children: randomLetterList
                          .map((e) => CustomWidget(
                                mw: mw,
                                mh: mh,
                                letter: e,
                              ))
                          .toList()),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomWidget extends StatelessWidget {
  const CustomWidget({
    Key? key,
    required this.mw,
    required this.mh,
    required this.letter,
  }) : super(key: key);

  final double mw;
  final double mh;
  final String letter;

  @override
  Widget build(BuildContext context) {
    return letter.isNotEmpty
        ? SizedBox(
            height: giveW(size: 50, mw: mw),
            width: giveW(size: 50, mw: mw),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: Colors.amber,
                elevation: 5,
              ),
              onPressed: () {},
              child: flexTextWidget(
                fontSize: giveH(size: 16, mh: mh),
                text: letter,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        : Container(
            width: giveW(size: 50, mw: mw),
            height: giveW(size: 50, mw: mw),
            margin: EdgeInsets.symmetric(
                vertical: giveH(size: 12, mh: mh),
                horizontal: giveW(size: 4, mw: mw)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10),
            ),
          );
  }
}

class ReplaceModel extends ChangeNotifier{
  String? keyWord;
  List<String>? randomLetterList;
  List<String>? emptyStringList;
  Map<String, List<dynamic>>? saveIndexArray;

  void replaceItems(String letter) {
    bool isNoNull = [keyWord, randomLetterList, emptyStringList, saveIndexArray]
        .every((element) => element != null);
    if (isNoNull) {
      if (emptyStringList!.every((element) => element.isNotEmpty)) {
      }

      else {
        if (saveIndexArray!.containsKey(letter)) {
          int randomLetterIndex = saveIndexArray![letter]![0];
          int emptyStringIndex = saveIndexArray![letter]![1];

          String tempVar = emptyStringList![randomLetterIndex];
          emptyStringList![randomLetterIndex] = randomLetterList![emptyStringIndex];
          randomLetterList![emptyStringIndex] = tempVar;

          saveIndexArray!.remove(letter);
          notifyListeners();

        } else {

          int emptyStringIndex = emptyStringList!.indexOf(
              emptyStringList!.firstWhere((element) => element.isEmpty));
          int randomLetterIndex = randomLetterList!.indexOf(letter);

          String tempVar =  emptyStringList![emptyStringIndex];
          emptyStringList![emptyStringIndex] = randomLetterList![randomLetterIndex];
          randomLetterList![randomLetterIndex] = tempVar;

          Map <String, List<int>> tempMap = {letter:[emptyStringIndex, randomLetterIndex]};
          saveIndexArray!.addEntries(tempMap.entries);
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
    final result = context.dependOnInheritedWidgetOfExactType<ReplaceInherited>()!.model;
    return result;
  }
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
