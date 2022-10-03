import 'package:hive/hive.dart';
part 'firebase_model.g.dart';

@HiveType(typeId: 0)
class FireBaseAnswerModel extends HiveObject{
  @HiveField(0)
  final String kgKeyWord;
  @HiveField(1)
  final String enKeyWord;

  FireBaseAnswerModel({
    required this.kgKeyWord,
    required this.enKeyWord,
  });

  @override
  String toString() {
    return 'kg: $kgKeyWord, en: $enKeyWord ';
  }
}
