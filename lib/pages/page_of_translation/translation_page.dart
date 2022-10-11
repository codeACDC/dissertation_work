import 'dart:async';

import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/main_page/main_page.dart';
import 'package:flutter/material.dart';

import '../../widgets/translations_inherited.dart';
import 'translation_page_body/translation_page_body.dart';

class TranslationPage extends StatefulWidget {
  TranslationPage({
    Key? key,
  }) : super(key: key);
  static const id = 'translation_page';

  @override
  State<TranslationPage> createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  final ValueNotifier<List<dynamic>?> binaryListValueNotifier =
      ValueNotifier<List<dynamic>?>(null);
  late Timer timer;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List tempArgs = ModalRoute.of(context)?.settings.arguments as List;
    final String tempKeyWord = tempArgs[0];
    final List<String> tempImagesUrl = tempArgs[1];

    final keyWord = tempKeyWord.toString();
    double mh = MediaQuery.of(context).size.height;
    // double mw = MediaQuery.of(context).size.width;
    return TranslationInherited(
      child: Builder(builder: (context) {
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          var tempBinaryListOfImages =
              TranslationInherited.of(context).binaryListOfImages;
          if (tempBinaryListOfImages != null) {
            binaryListValueNotifier.value = tempBinaryListOfImages;
          }
        });

        if (TranslationInherited.of(context).binaryListOfImages !=
            null) {
          Navigator.of(context).pushReplacementNamed(MainPage.id);
        }

        return WillPopScope(
          onWillPop: () => onBackButtonPressed(context),
          child: Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(giveH(size: 10, mh: mh)),
                      bottomRight: Radius.circular(giveH(size: 10, mh: mh)))),
              title: Text(
                'Сөз: ${keyWord.replaceFirst(keyWord[0], keyWord[0].toUpperCase())}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: giveH(size: 12.3, mh: mh)),
              ),
            ),
            body: SafeArea(
                child: TranslationPageBody(
                    keyWord: keyWord, imagesUrl: tempImagesUrl)),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                if (TranslationInherited.of(context).binaryListOfImages !=
                    null) {
                  Navigator.of(context).pushReplacementNamed(MainPage.id);
                }
              },
              child: ValueListenableBuilder(
                valueListenable: binaryListValueNotifier,
                builder: (context, binaryListOfImages, _) {
                  if (binaryListOfImages != null) {
                    return Icon(
                      Icons.check,
                      color: Colors.black,
                      size: giveH(size: 20, mh: mh),
                    );
                  } else {
                    return const CircularProgressIndicator(
                      color: Colors.black,
                    );
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
