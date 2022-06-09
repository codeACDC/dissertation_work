import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../main_page/main_page_body/main_page_body_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static const id = 'main_page';

  @override
  Widget build(BuildContext context) {
    double mh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape:  RoundedRectangleBorder(
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
      body: const SafeArea(child: MainPageBody()),
    );
  }
}
