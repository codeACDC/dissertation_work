import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:flutter/material.dart';

class CarouselIndicatorWidget extends StatelessWidget {
  final int currentPhotoIndex;
  final int totalQuantityOfPhoto;
  final double mh;
  final double mw;

  const CarouselIndicatorWidget({
    Key? key,
    required this.mh,
    required this.mw,
    this.currentPhotoIndex = 0,
    required this.totalQuantityOfPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> allPhotoIndicator = [];

    for (int i = 0; i < totalQuantityOfPhoto; i++) {
      allPhotoIndicator.add(currentPhotoIndicator(
          currentPhotoIndex: currentPhotoIndex, index: i, mh: mh, mw: mw));
    }
    return Center(
        child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: allPhotoIndicator,
    ));
  }
}

Widget currentPhotoIndicator({
  required int currentPhotoIndex,
  required int index,
  required double mh,
  required double mw,
}) {
  return Container(
    height: 5,
    width: giveW(size: 10, mw: mw),
    margin: EdgeInsets.all(giveH(size: 3, mh: mh)),
    decoration: BoxDecoration(
        color: index == currentPhotoIndex
            ? ConstColor.translationText
            : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh))),
  );
}
