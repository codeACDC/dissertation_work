import 'package:hive/hive.dart';
part 'firebase_model.g.dart';

@HiveType(typeId: 1)
class FireBaseAnswerModel extends HiveObject{
  @HiveField(0)
  String kgKeyWord;
  @HiveField(1)
  String enKeyWord;

  FireBaseAnswerModel({
    required this.kgKeyWord,
    required this.enKeyWord,
  });
}
