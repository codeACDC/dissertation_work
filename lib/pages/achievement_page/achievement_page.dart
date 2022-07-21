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

    return Scaffold(
      backgroundColor: ConstColor.blackBoard0C,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[800],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(giveH(size: 10, mh: mh)),
                bottomLeft: Radius.circular(giveH(size: 10, mh: mh)))),
        title: flexTextWidget(
          text: 'Достижения',
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
                              text: 'Нет разгаданных слов!',
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
                                    mainAxisSpacing: giveH(size: 10, mh: freeMh),
                                    crossAxisSpacing:
                                        giveW(size: 15, mw: freeMw)),
                            itemCount: answerBox.length,
                            itemBuilder: (context, index) {
                              AnswerModel answerModelAtIndex =
                                  answerBox.values.elementAt(index);
                              String keyWord = answerModelAtIndex.word;
                              List imagesUrl =
                                  answerModelAtIndex.imagesUrl;

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
