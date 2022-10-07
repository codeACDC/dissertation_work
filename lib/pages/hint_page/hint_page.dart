import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/hint_page/hint_page_body.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HintPage extends StatelessWidget {
  const HintPage({Key? key}) : super(key: key);
  static const id = 'hint_page';

  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery.of(context).size.height;
    // final double mw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColor.blackBoard0C,
      appBar: AppBar(
        title: flexTextWidget(
          text: 'Кеңешмелер',
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(giveH(size: 10, mh: mh)),
                bottomRight: Radius.circular(giveH(size: 10, mh: mh)))),
        backgroundColor: Colors.deepPurple[800],
      ),
body: const HintPageBody(),
    );
  }
}
