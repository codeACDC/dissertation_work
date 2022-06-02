import 'package:dissertation_work/widgets/models/letter_model.dart';
import 'package:flutter/material.dart';

import '../constants/methods/methods.dart';
import 'custom_widget.dart';
import 'replace_inherited_widget.dart';

class AnimatedEmptyListWidget extends StatelessWidget {
  const AnimatedEmptyListWidget({
    Key? key,
    required this.mw,
    required this.mh,
    required this.correctAnswerModel,
  }) : super(key: key);

  final double mw;
  final double mh;
  final CorrectAnswerModel? correctAnswerModel;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: ReplaceInherited.of(context).inCorrectAnswerAlign ?? Alignment.center,
      duration: const Duration(milliseconds: 100),

      child: Container(
        height: giveW(size: 70, mw: mw),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: giveH(size: 10, mh: mh),
                  color: answerColor(correctAnswerModel!.isCorrect))
            ],
            borderRadius:
            BorderRadius.circular(giveH(size: 10, mh: mh))),
        margin: EdgeInsets.symmetric(
            vertical: giveH(size: 10, mh: mh)),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
            (ReplaceInherited.of(context)
                .emptyStringList ?? [])
                .map((e) => CustomWidget(
              mw: mw,
              mh: mh,
              letterElem: e,
            ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
