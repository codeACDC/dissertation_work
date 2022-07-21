import 'package:hive/hive.dart';
part 'answer_model.g.dart';

@HiveType(typeId: 0)
class AnswerModel extends HiveObject{
  @HiveField(0)
  final String word;
  @HiveField(1, defaultValue: false)
  bool isCorrectAnswer;
  @HiveField(2, defaultValue: [])
  List imagesUrl;
  @HiveField(3, defaultValue: [])
  List totalList;

  AnswerModel({
    required this.word,
    required this.imagesUrl,
    required this.totalList,
    this.isCorrectAnswer = false,

  });
}
