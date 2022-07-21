import 'package:dissertation_work/pages/start_page/start_page_body.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/methods/methods.dart';
import '../../widgets/widgets.dart';
import '../main_page/drawer/main_page_drawer.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);
  static const String id = 'start_page';

  @override
  Widget build(BuildContext context) {
    double mh = MediaQuery.of(context).size.height;
    double mw = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () => onBackButtonPressed(context),
      child: Scaffold(
        backgroundColor: ConstColor.blackBoard0C,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(giveH(size: 10, mh: mh)),
              bottomRight: Radius.circular(giveH(size: 10, mh: mh)),
            ),
          ),
          backgroundColor: Colors.deepPurple[800],
          title: flexTextWidget(
            text: 'Word finder',
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        body: const StartPageBody(),
      ),
    );
  }
}
