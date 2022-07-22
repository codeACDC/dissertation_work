import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/translations_inherited.dart';
import 'translation_page_body/translation_page_body.dart';

class TranslationPage extends StatefulWidget {
  const TranslationPage({
    Key? key,
  }) : super(key: key);
  static const id = 'translation_page';

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  @override
  Widget build(BuildContext context) {
    final List tempArgs = ModalRoute.of(context)?.settings.arguments as List;
    final String tempKeyWord = tempArgs[0];
    final List<String> tempImagesUrl = tempArgs[1];

    final keyWord = tempKeyWord.toString();
    double mh = MediaQuery.of(context).size.height;
    return TranslationInherited(
      child: Builder(
        builder: (context) {
          TranslationInherited.of(context).translation = null;
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
            body: SafeArea(
                child: TranslationPageBody(
                    keyWord: keyWord, imagesUrl: tempImagesUrl)),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.navigate_next,
                size: giveH(size: 25, mh: mh),
                color: Colors.black,
              ),
              backgroundColor: Colors.amber,
              onPressed: () {
          var translations = TranslationInherited.of(context).translation;

                if (translations != null) {
                  Navigator.of(context).pushReplacementNamed(MainPage.id);
                }
              },
            ),
          );
        }
      ),
    );
  }
}
