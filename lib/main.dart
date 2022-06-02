import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/pages/page_of_translation/translation_page.dart';
import 'package:flutter/material.dart';

import 'pages/main_page/main_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dissertation app',
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: ConstColor.blackBoard0C,
      ),
      home: const MainPage(),
      routes: {
        MainPage.id: (context)=> const MainPage(),
        TranslationPage.id: (context) => const TranslationPage(),
      },
    );
  }
}
