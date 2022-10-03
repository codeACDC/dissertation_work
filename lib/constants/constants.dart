import 'package:flutter/cupertino.dart';

class Constants {
  static const String pixApiKey = '26135823-6805a1b7eb2b4f15fe639b6de';
  static const String yandexDictApiKey =
      'dict.1.1.20220531T093521Z.4df76d6ce4cfca57.45cf38f86dfee013c2e1bb523380c2aa8c436798';
  static const List<String> alphabetList =
  ['А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И', 'Й', 'К', 'Л',
    'М', 'Н','Ң', 'П', 'Р', 'С', 'Т', 'О', 'Ө', 'У', 'Ү', 'Ф', 'Х', 'Ч','Ц' 'Ъ','Ь','Ш','Щ','Ы','Э','Ю','Я'];
  static const Map<String, String> soundEffectsMap = {
    'correctSoundPath': 'lib/sound_effects/correct_answer.mp3',
    'inCorrectSoundPath': 'lib/sound_effects/wrong_answer.mp3',
  };
  static const answerBox = 'answer_box';
  static const keyWordBox = 'key_word_box';
  static const saveChangeBox = 'save_change_box';
  static const fireBaseBox = 'fire_base_box';
  static const firebaseCollectionName = 'keyWords';
  static const firebaseCompetitionCollectionName = 'competitionKeyWords';
  static const firebaseKeyWordDocName = 'nouns';
  static const soundVolumeStateBox = 'sound_volume_state_box';
}

class ConstColor {
  static const Color greyBoard31 = Color(0xFF313131);
  static const Color blackBoard0C = Color(0xFF0C0C0C);
  static const Color translationText = Color.fromRGBO(222, 190, 73, 1);
  static const Color translationContainerBG = Color.fromRGBO(37, 36, 39, 1);
  static const Color wordContainerBG = Color.fromRGBO(222, 190, 73, 0.1);
  static const Color darkContainerBG = Color.fromRGBO(18, 18, 20, 1);
  static const Color containerBorder = Color.fromRGBO(255, 255, 255, 0.12);
  static const Color secondaryText = Color.fromRGBO(255, 255, 255, 0.7);
}
