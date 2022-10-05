import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/pages/achievement_page/achievement_page.dart';
import 'package:dissertation_work/pages/hint_page/hint_page.dart';
import 'package:dissertation_work/pages/page_of_translation/translation_page.dart';
import 'package:dissertation_work/pages/start_page/start_page.dart';
import 'package:dissertation_work/widgets/models/answer_model.dart';
import 'package:dissertation_work/widgets/models/firebase_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'pages/main_page/main_page.dart';

void main() async {
  SentryFlutter.init((p0) {
    p0.dsn =
        'https://0c4ad0a852ad47d6a1ebd62dca879481@o1181471.ingest.sentry.io/6294861';
    p0.tracesSampleRate = 1.0;
  }, appRunner: () async {
    WidgetsFlutterBinding.ensureInitialized();
    var appDocDir = await getApplicationDocumentsDirectory();
     Hive
       ..initFlutter(appDocDir.path)
      ..registerAdapter(FireBaseAnswerModelAdapter())
      ..registerAdapter(AnswerModelAdapter());

    await Hive.openBox(Constants.answerBox);
    await Hive.openBox(Constants.keyWordBox);
    await Hive.openBox(Constants.saveChangeBox);
    await Hive.openBox(Constants.fireBaseBox);
    await Hive.openBox(Constants.soundVolumeStateBox);
    await Firebase.initializeApp();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    try {
      runApp(const MyApp());
    } catch (exception, stackTrace) {
      debugPrint(exception.toString());
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  });
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
      home: const StartPage(),
      routes: {
        StartPage.id: (context) => const StartPage(),
        MainPage.id: (context) => const MainPage(),
        TranslationPage.id: (context) =>  TranslationPage(),
        AchievementPage.id: (context) => const AchievementPage(),
        HintPage.id: (context) => const HintPage(),
      },
    );
  }
}
