import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dissertation_work/bloc/image_loader/image_loader_cubit.dart';
import 'package:dissertation_work/pages/main_page/main_page_body/grid_of_image.dart';
import 'package:dissertation_work/widgets/models/firebase_model.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

import '../../../constants/constants.dart';
import '../../../constants/methods/methods.dart';
import '../../../widgets/animated_empty_list_widget.dart';
import '../../../widgets/models/letter_model.dart';
import '../../../widgets/models/replace_model.dart';
import '../../../widgets/random_letter_list_widget.dart';
import '../../../widgets/replace_inherited_widget.dart';

class MainPageBody extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const MainPageBody({
    Key? key,
    required this.audioPlayer,
  }) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  late final Map<LetterModel, List<dynamic>> saveIndexArray;
  late final List<LetterModel> randomLetterList;
  late final List<LetterModel> emptyStringList;
  late final FireBaseAnswerModel keyWord;
  late final String tempKeyWord;
  late final String searchKeyWord;
  late final CorrectAnswerModel correctAnswerModel;
  late final Alignment inCorrectAnswerAlign;
  final confettiController = ConfettiController(
      duration: const Duration(
    milliseconds: 500,
  ));

  @override
  void initState() {
    //check for changes in keyWord list
    detectChanges();

    //Preparation data
    keyWord = nextKeyWord();
    tempKeyWord = keyWord.kgKeyWord;

    debugPrint('Key word: $tempKeyWord');
    correctAnswerModel =
        CorrectAnswerModel(correctAnswer: tempKeyWord, isCorrect: null);
    List<String> tempRandomLetterList = tempKeyWord.toUpperCase().split('');

    tempRandomLetterList.addAll(Constants.alphabetList.where((elem) =>
    !tempRandomLetterList.contains(elem) &&
        tempRandomLetterList.length < 12));
    tempRandomLetterList.shuffle();

    List<String> tempEmptyStringList =
    List<String>.filled(tempKeyWord.length, '');

    //Preparation LetterClass List
    saveIndexArray = {};

    randomLetterList = tempRandomLetterList
        .map((e) =>
        LetterModel(
          letter: e,
          id: UniqueKey().toString(),
        ))
        .toList();

    emptyStringList = tempEmptyStringList
        .map((e) =>
        LetterModel(
          letter: e,
          id: UniqueKey().toString(),
        ))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReplaceInherited(
      model: ReplaceModel(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          double mh = constraints.maxHeight;
          double mw = constraints.maxWidth;

          ReplaceInherited.of(context).randomLetterList = randomLetterList;
          ReplaceInherited.of(context).emptyStringList = emptyStringList;
          ReplaceInherited.of(context).saveIndexArray = saveIndexArray;
          ReplaceInherited.of(context).correctAnswerModel = correctAnswerModel;
          if (ReplaceInherited.of(context).imagesUrl != null) {
            showCongratulation(
                keyWord: tempKeyWord,
                imagesUrl: ReplaceInherited.of(context).imagesUrl!,
                confettiController: confettiController,
                isCorrect:
                    ReplaceInherited.of(context).correctAnswerModel!.isCorrect,
                context: context,
                mh: mh,
                mw: mw);
          }
          playSound(
            audioPlayer: widget.audioPlayer,
            isCorrectAnswer:
                ReplaceInherited.of(context).correctAnswerModel!.isCorrect,
          );

          return Container(
            height: mh,
            width: mw,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: giveW(size: 10, mw: mw)),
              //Image load bloc
              child: BlocProvider<ImageLoaderCubit>(
                create: (context) =>
                    ImageLoaderCubit(searchText: searchKeyWord)..getPhotos(),
                child: ConfettiWidget(
                  maxBlastForce: 50,
                  gravity: 0.5,
                  numberOfParticles: 50,
                  blastDirection: -pi / 2,
                  blastDirectionality: BlastDirectionality.explosive,
                  confettiController: confettiController,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: giveH(size: 10, mh: mh)),
                          child:
                              BlocBuilder<ImageLoaderCubit, ImageLoaderState>(
                                  buildWhen: (previousState, currentState) =>
                                      previousState != currentState,
                                  builder: (context, state) {
                                    if (state is ImageLoaderLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.deepPurple[800],
                                        ),
                                      );
                                    }
                                    if (state is ImageLoaderLoaded) {
                                      ReplaceInherited.of(context).imagesUrl =
                                          state.loadedImages;

                                      return GridOfImage(
                                          mh: mh,
                                          mw: mw,
                                          urlsOfImage: state.loadedImages);
                                    }
                                    if (state is ImageLoaderError) {
                                      debugPrint(state.errorMessage);
                                      return Center(
                                        child: MaterialButton(
                                          elevation: giveH(size: 3, mh: mh),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                giveH(size: 5, mh: mh)),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<ImageLoaderCubit>()
                                                .getPhotos();
                                          },
                                          color: Colors.deepPurple[800],
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.repeat,
                                                color: Colors.white,
                                              ),
                                              flexTextWidget(
                                                  text: '  Повторить',
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400)
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                        ),
                      ),

                      //Empty widget list
                      AnimatedEmptyListWidget(
                        mw: mw,
                        mh: mh,
                        correctAnswerModel:
                            ReplaceInherited.of(context).correctAnswerModel,
                      ),

                      //Letter widget list
                      RandomLetterListWidget(mh: mh, mw: mw)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
