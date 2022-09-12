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
    final List tempArgs = ModalRoute
        .of(context)
        ?.settings
        .arguments as List;
    final String tempKeyWord = tempArgs[0];
    final List<String> tempImagesUrl = tempArgs[1];

    final keyWord = tempKeyWord.toString();
    double mh = MediaQuery
        .of(context)
        .size
        .height;
    // double mw = MediaQuery.of(context).size.width;
    return TranslationInherited(
      child: Builder(builder: (context) {
        TranslationInherited
            .of(context)
            .binaryListOfImages = null;
        return WillPopScope(
          onWillPop: () => onBackButtonPressed(context),
          child: Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(giveH(size: 10, mh: mh)),
                      bottomRight: Radius.circular(giveH(size: 10, mh: mh)))),
              title: Text(
                  'Слово ${keyWord.replaceFirst(
                      keyWord[0], keyWord[0].toUpperCase())}'),
              backgroundColor: Colors.deepPurple[800],
            ),
            body: SafeArea(
                child: TranslationPageBody(
                    keyWord: keyWord, imagesUrl: tempImagesUrl)),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {
                  if (TranslationInherited
                      .of(context)
                      .binaryListOfImages !=
                      null) {
                    Navigator.of(context).pushReplacementNamed(MainPage.id);
                  }
                },
                child: StreamBuilder(
                  stream: streamOfTranslationInheritedVariable(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Icon(
                        Icons.check,
                        size: giveH(size: 25, mh: mh),
                        color: Colors.black,
                      );
                    } else if (!snapshot.hasData) {
                      return const CircularProgressIndicator(
                          color: Colors.black);
                    } else {
                      return Icon(
                        Icons.error_outline,
                        size: giveH(size: 25, mh: mh),
                        color: Colors.black,
                      );
                    }
                  },
                )),
          ),
        );
      }),
    );
  }

  Stream<List<dynamic>?> streamOfTranslationInheritedVariable() async*{
    var binaryListOfImages = TranslationInherited.of(context).binaryListOfImages;
    try{
      while (true) {
        if (binaryListOfImages != null) {
          yield binaryListOfImages;
          break;
        }
      }
    }
    catch(e) {
      debugPrint(e.toString());
    }
  }
}


