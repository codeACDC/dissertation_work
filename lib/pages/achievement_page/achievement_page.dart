import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/achievement_page/achievement_page_widgets/preview_hero_widget.dart';
import 'package:dissertation_work/widgets/models/answer_model.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../constants/constants.dart';

class AchievementPage extends StatelessWidget {
  static const String id = 'achievement_page';

  const AchievementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery.of(context).size.height;
    final double mw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColor.blackBoard0C,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Wrap(
                        children:[ Text(
                            'Сиздин баардык жетишкендиктериңиз өчөт!',
                        style:TextStyle(fontSize: giveH(size: 12, mh: mh),
                            fontWeight: FontWeight.w600,
                            color: Colors.white, fontFamily: 'Roboto'))
                          ]
                      ),
                      alignment: Alignment.center,
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(giveH(size: 10, mh: mh))),
                      elevation: giveH(size: 2, mh: mh),
                      actionsPadding: EdgeInsets.symmetric(
                          horizontal: giveW(size: 14, mw: mw),
                          vertical: giveH(size: 5, mh: mh)),
                      backgroundColor: ConstColor.blackBoard0C,
                      actions: [
                        AlertButtonWidget(
                          mh: mh,
                          text: 'Ооба',
                          onPressed: deleteAllData,
                        ),
                        AlertButtonWidget(
                          mh: mh,
                          text: 'Жок',
                          onPressed: (){},
                        )
                      ],
                    );
                  }
                );}
              ,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
        backgroundColor: Colors.deepPurple[800],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(giveH(size: 10, mh: mh)),
                bottomLeft: Radius.circular(giveH(size: 10, mh: mh)))),
        title: flexTextWidget(
          text: 'Жетишкендиктер',
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final double freeMh = constraints.maxHeight;
        final double freeMw = constraints.maxWidth;

        return DecoratedBox(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: freeMw,
                height: freeMh,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: giveH(size: 10, mh: freeMh),
                      horizontal: giveW(size: 15, mw: freeMw)),
                  child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box(Constants.answerBox).listenable(),
                      builder: (context, Box box, _) {
                        if (box.values.isEmpty) {
                          return Center(
                            child: flexTextWidget(
                              text: 'Ачылган сөздөр жок!',
                              fontSize: giveH(size: 15, mh: freeMh),
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          );
                        }
                        var answerBox = Hive.box(Constants.answerBox);
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing:
                                        giveH(size: 10, mh: freeMh),
                                    crossAxisSpacing:
                                        giveW(size: 15, mw: freeMw)),
                            itemCount: answerBox.length,
                            itemBuilder: (context, index) {
                              AnswerModel answerModelAtIndex =
                                  answerBox.values.elementAt(index);
                              String keyWord = answerModelAtIndex.word;
                              List imagesUrl = answerModelAtIndex.imagesUrl;

                              List totalList = answerModelAtIndex.totalList;

                              // debugPrint('length of image url: ' + imagesUrl.first.length.toString());

                              return PreviewHeroWidget(
                                  mh: freeMh,
                                  mw: freeMw,
                                  totalList: totalList,
                                  imagesUrl: imagesUrl,
                                  keyWord: keyWord);
                            });
                      }),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class AlertButtonWidget extends StatelessWidget {
  const AlertButtonWidget({
    Key? key,
    required this.mh,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final double mh;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        onPressed();
        Navigator.of(context).pop();
      },
      color: ConstColor.translationText,
      elevation: giveH(size: 1, mh: mh),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(giveH(size: 5, mh: mh))),
      child: flexTextWidget(
          text: text,
          fontSize: giveH(size: 12, mh: mh),
          fontWeight: FontWeight.w500),
    );
  }
}
