import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

import 'translation_page_body/translation_page_body.dart';

class TranslationPage extends StatelessWidget {
  const TranslationPage({
    Key? key,
  }) : super(key: key);
  static const id = 'translation_page';

  @override
  Widget build(BuildContext context) {
    final tempKeyWord = ModalRoute.of(context)!.settings.arguments ?? '';
    final keyWord = tempKeyWord.toString();
    double mh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(giveH(size: 10, mh: mh)),
                bottomRight: Radius.circular(giveH(size: 10, mh: mh)))),
        title: Text(
            'Слово ${keyWord.replaceFirst(keyWord[0], keyWord[0].toUpperCase())}'),
        backgroundColor: Colors.deepPurple[800],
      ),
      body: SafeArea(child: TranslationPageBody(keyWord: keyWord)),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.navigate_next,
          size: giveH(size: 25, mh: mh),
          color: Colors.black,
        ),
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(MainPage.id);
        },
      ),
    );
  }
}