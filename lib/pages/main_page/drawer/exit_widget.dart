import 'dart:io';

import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ExitWidget extends StatelessWidget {
  const ExitWidget({Key? key}) : super(key: key);
static const String id = 'exit';
  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery.of(context).size.height;
    final double mw = MediaQuery.of(context).size.width;

    return AlertDialog(
      titlePadding: EdgeInsets.only(
          top: giveH(size: 10, mh: mh),
          bottom: giveH(size: 30, mh: mh),
          right: giveW(size: 10, mw: mw),
          left: giveW(size: 10, mw: mw)),
      title: flexTextWidget(
          text: 'Вы хотите выйти?',
          fontSize: giveH(size: 16, mh: mh),
          fontWeight: FontWeight.w600,
          color: Colors.white),
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh))),
      elevation: giveH(size: 2, mh: mh),
      backgroundColor: ConstColor.blackBoard0C,
      actionsPadding: EdgeInsets.symmetric(horizontal: giveW(size: 14, mw: mw), vertical: giveH(size: 5, mh: mh)),
      actions: [
        MaterialButton(
          onPressed: () {
            //Open all hive boxes
            var keyWordBox = Hive.box(Constants.keyWordBox);
            var changesBox = Hive.box(Constants.saveChangeBox);
            var firebaseBox = Hive.box(Constants.fireBaseBox);
            var answerBox = Hive.box(Constants.answerBox);
            var soundVolumeStateBox = Hive.box(Constants.soundVolumeStateBox);

            List<Box> boxList = [
              keyWordBox,
              changesBox,
              firebaseBox,
              answerBox,
              soundVolumeStateBox,
            ];

            //And check isOpen after this action close all boxes
            for (var box in boxList) {
              if(box.isOpen) {
                box.compact();
                box.close();
              }
            }
            exit(0);
          },
          color: ConstColor.translationText,
          elevation: giveH(size: 1, mh: mh),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(giveH(size: 5, mh: mh))),
          child: flexTextWidget(text: 'Да', fontSize: giveH(size: 12, mh: mh), fontWeight: FontWeight.w500,),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          color: ConstColor.translationText,
          elevation: giveH(size: 1, mh: mh),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(giveH(size: 5, mh: mh))),
          child: flexTextWidget(text: 'Нет', fontSize: giveH(size: 12, mh: mh), fontWeight: FontWeight.w500,),
        ),
      ],
      actionsAlignment: MainAxisAlignment.spaceBetween,
    );
  }
}
