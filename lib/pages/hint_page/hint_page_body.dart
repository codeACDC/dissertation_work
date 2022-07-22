import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../../constants/constants.dart';

class HintPageBody extends StatelessWidget {
  const HintPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double mh = constraints.maxHeight;
      final double mw = constraints.maxWidth;

      return Container(
        width: mw,
        height: mh,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: giveW(size: 20, mw: mw),
                vertical: giveH(size: 10, mh: mh)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                flexTextWidget(
                  text: 'Ключевые слова:',
                  fontSize: giveH(size: 20, mh: mh),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                SizedBox(height: giveH(size: 10, mh: mh)),
                ValueListenableBuilder(
                    valueListenable:
                        Hive.box(Constants.fireBaseBox).listenable(),
                    builder: (context, Box box, _) {
                      if (box.isEmpty) {
                        return flexTextWidget(
                          text: 'Нету нужной информации',
                          fontSize: giveH(size: 16, mh: mh),
                          fontWeight: FontWeight.w500,
                          color: ConstColor.translationText,
                        );
                      }
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          ...box.values.map((e)
                      {
                        int index = box.values.toList().indexOf(e);
                       return Container(
                          padding: EdgeInsets.all(giveH(size: 2, mh: mh)),
                          margin: EdgeInsets.only(
                              bottom: giveH(size: 10, mh: mh)),
                          decoration: BoxDecoration(
                              color: ConstColor.translationText,
                              borderRadius: BorderRadius.circular(
                                  giveH(size: 10, mh: mh))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: giveW(size: 10, mw: mw)),
                                decoration: BoxDecoration(
                                    color: ConstColor.blackBoard0C,
                                    borderRadius: BorderRadius.circular(
                                        giveH(size: 20, mh: mh))),
                                child: flexTextWidget(
                                    text: ' '+(index + 1).toString()+' ',
                                    fontSize: giveH(size: 14, mh: mh),
                                    fontWeight: FontWeight.w600,
                                    color: ConstColor.translationText),
                              ),
                              flexTextWidget(
                                  text: box.values.elementAt(index) + '  ',
                                  fontSize: giveH(size: 14, mh: mh),
                                  fontWeight: FontWeight.w500,
                                  color: ConstColor.blackBoard0C),
                            ],
                          ),
                        );},
                      )]);
                    })
              ],
            ),
          ),
        ),
      );
    });
  }
}
