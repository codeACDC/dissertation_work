import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/pages/achievement_page/achievement_page.dart';
import 'package:dissertation_work/pages/page_of_translation/translation_page.dart';
import 'package:dissertation_work/widgets/models/answer_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'pages/main_page/main_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await  Hive.initFlutter();
  Hive.registerAdapter(AnswerModelAdapter());
  await Hive.openBox(Constants.answerBox);
  await Hive.openBox(Constants.keyWordBox);
  await Hive.openBox(Constants.saveChangeBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word finder',
      theme: Theme.of(context).copyWith(
        scaffoldBackgroundColor: ConstColor.blackBoard0C,
      ),
      home: const MainPage(),
      routes: {
        MainPage.id: (context) => const MainPage(),
        TranslationPage.id: (context) => const TranslationPage(),
        AchievementPage.id: (context) => const AchievementPage(),
      },
    );
  }
}
