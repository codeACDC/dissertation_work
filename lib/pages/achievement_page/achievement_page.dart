import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class AchievementPage extends StatelessWidget {
  static const String id = 'achievement_page';

  const AchievementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: flexTextWidget(
          text: 'Достижения',
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.deepPurple[800],
      body: LayoutBuilder(builder: (context, constraints) {
        final double mh = constraints.maxHeight;
        // final double mw = constraints.maxWidth;

        return DecoratedBox(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(
            children: [
              Center(
                  child: flexTextWidget(
                      text: 'Data', fontSize: giveH(size: 20, mh: mh)))
            ],
          ),
        );
      }),
    );
  }
}
