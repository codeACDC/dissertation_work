import 'package:hive/hive.dart';
part 'answer_model.g.dart';

@HiveType(typeId: 0)
class AnswerModel extends HiveObject{
  @HiveField(0)
  final String word;
  @HiveField(1,defaultValue: false)
  bool isCorrectAnswer;
  @HiveField(2, defaultValue: [])
  List? synonyms;
  @HiveField(3, defaultValue: [])
  List? examples;
  @HiveField(4, defaultValue: [])
  List? translates;
  @HiveField(5, defaultValue: [])
  List? imagesUrl;
  @HiveField(6, defaultValue: [])
  List? totalList;

  AnswerModel({
    required this.word,
    this.imagesUrl,
    this.totalList,
    this.isCorrectAnswer = false,
    this.examples =  const [],
    this.synonyms = const [],
    this.translates = const [],
  });
}
