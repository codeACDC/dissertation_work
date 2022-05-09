import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'main_page_body/main_page_body_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        title: flexTextWidget(
          text: 'Dissertation app',
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      body: const SafeArea(child: MainPageBody()),
    );
  }
}
