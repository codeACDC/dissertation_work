import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'title_translation_widget.dart';
import 'word_translations_widget.dart';

class TranslationWidget extends StatelessWidget {
  final double mh;
  final double mw;
  final Map<String, dynamic> translationMap;

  const TranslationWidget({
    Key? key,
    required this.mh,
    required this.mw,
    required this.translationMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List<Map>
    final translationList = translationMap['tr'];

    List synonymsList = translationList.map((e) {
      if (e.containsKey('syn')) {
        for (int i = 0; i < e['syn'].length; i++) {
          return e['syn'][i]['text'];
        }
      }
    }).toList();

    synonymsList.removeWhere((element) => element == null);
    List exampleList = [];
    translationList.forEach((element) {
      if (element.containsKey('ex')) {
        List tempList = (element['ex'] as List);
        exampleList.addAll(tempList);
      }
    });
    return Container(
      margin: EdgeInsets.symmetric(vertical: giveH(size: 10, mh: mh)),
      decoration: BoxDecoration(
        color: ConstColor.darkContainerBG,
        border: Border.all(color: ConstColor.containerBorder),
        borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh)),
      ),
      child: Padding(
          padding: EdgeInsets.all(giveH(size: 10, mh: mh)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleTranslationWidget(
                  mh: mh, mw: mw, translationMap: translationMap),
              WordTranslationsWidget(
                  mw: mw, mh: mh, translationList: translationList),
              synonymsList.isEmpty
                  ? const SizedBox()
                  : Container(
                margin: EdgeInsets.symmetric(
                    vertical: giveH(size: 5, mh: mh)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    flexTextWidget(
                      text: 'Синонимы:',
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: Wrap(
                            alignment: WrapAlignment.end,
                            runSpacing: giveW(size: 5, mw: mw),
                            spacing: giveW(size: 5, mw: mw),
                            children: [
                              ...synonymsList.map((e) =>
                                  Container(
                                      margin: EdgeInsets.only(
                                        bottom: giveH(size: 5, mh: mh),
                                        // right: giveH(size: 5, mh: mh),
                                        // left: giveH(size: 5, mh: mh),
                                      ),
                                      height: giveH(size: 16, mh: mh),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            giveH(size: 2, mh: mh)),
                                        child: flexTextWidget(
                                          boxFit: BoxFit.contain,
                                          text: e,
                                          fontSize: giveH(size: 11, mh: mh),
                                          color: ConstColor.translationText,
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: ConstColor
                                            .translationContainerBG,
                                        borderRadius: BorderRadius.circular(
                                            giveH(size: 20, mh: mh)),
                                      )))
                            ]))
                  ],
                ),
              ),
              exampleList.isEmpty
                  ? const SizedBox()
                  : Container(
                margin: EdgeInsets.symmetric(
                    vertical: giveH(size: 5, mh: mh)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    flexTextWidget(
                      text: 'Примеры:',
                      fontSize: giveH(size: 9, mh: mh),
                      color: Colors.white,
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(top: giveH(size: 5, mh: mh)),
                      height: giveH(size: 40, mh: mh),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: exampleList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              LimitedBox(
                                maxWidth: giveW(size: 150, mw: mw),
                                child: Container(
                                  width: giveW(size: 140, mw: mw),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: giveW(size: 3, mw: mw)),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          giveH(size: 10, mh: mh)),
                                      color: ConstColor
                                          .translationContainerBG),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        giveH(size: 3, mh: mh)),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        flexTextWidget(
                                            boxFit: BoxFit.contain,
                                            fontSize:
                                            giveH(size: 16, mh: mh),
                                            text: exampleList[index]
                                                .containsKey('text')
                                                ? exampleList[index]
                                            ['text']
                                                : '',
                                            color: Colors.white),
                                        flexTextWidget(
                                            boxFit: BoxFit.contain,
                                            fontSize:
                                            giveH(size: 14, mh: mh),
                                            text: exampleList[index]
                                                .containsKey('tr')
                                                ? exampleList[index]['tr']
                                                .first['text']
                                                : '',
                                            color:
                                            ConstColor.secondaryText),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
