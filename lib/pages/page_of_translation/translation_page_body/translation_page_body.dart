import 'package:dissertation_work/bloc/translate_data_loader/translate_loader_cubit.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/page_of_translation/translation_page_widgets/translation_widget.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';
import '../../../widgets/translations_inherited.dart';

class TranslationPageBody extends StatefulWidget {
  final String keyWord;
  final List<String> imagesUrl;

  TranslationPageBody({
    Key? key,
    required this.keyWord,
    required this.imagesUrl,
  }) : super(key: key);

  @override
  State<TranslationPageBody> createState() => _TranslationPageBodyState();
}

class _TranslationPageBodyState extends State<TranslationPageBody> {
  late List binaryListOfImages;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double mw = constraints.maxWidth;
      double mh = constraints.maxHeight;

      return Container(
        width: mw,
        height: mh,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: BlocProvider<TranslatorCubit>(
          create: (context) =>
              TranslatorCubit(search: widget.keyWord)..translationParser(),
          child: BlocBuilder<TranslatorCubit, TranslatorState>(
              buildWhen: (previousState, currentState) =>
                  previousState != currentState,
              builder: (context, state) {
                if (state is TranslatorError) {
                  return Center(
                    child: MaterialButton(
                      elevation: giveH(size: 3, mh: mh),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(giveH(size: 5, mh: mh)),
                      ),
                      onPressed: () {
                        context.read<TranslatorCubit>().translationParser();
                      },
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
                      color: Colors.deepPurple[800],
                    ),
                  );
                }
                if (state is TranslatorLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple[800],
                    ),
                  );
                }
                if (state is TranslatorLoaded) {
                  Future.delayed(Duration.zero, () {
                    super.setState(() => () async {
                      binaryListOfImages =
                      await toBinaryDataConverter(imagesUrl: widget.imagesUrl);
                    });
                  });
                  TranslationInherited.of(context).binaryListOfImages = binaryListOfImages;
                  final List definitionList = state.loadedTranslation;

                  bool isNotNull =
                      TranslationInherited.of(context).binaryListOfImages !=
                          null;
                  print(TranslationInherited.of(context).binaryListOfImages);
                  debugPrint('is not null: ' + isNotNull.toString());
                  if (isNotNull) {
                    addToKeyWordBoxWhenTrue(
                      keyWord: widget.keyWord,
                    );
                    addNewAnswerModel(
                        keyWord: widget.keyWord,
                        imagesUrl: TranslationInherited.of(context)
                            .binaryListOfImages!,
                        totalList: definitionList);
                  }
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: giveW(size: 20, mw: mw),
                          vertical: giveH(size: 10, mh: mh)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          flexTextWidget(
                            text: 'Словарь',
                            fontSize: giveH(size: 20, mh: mh),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          ...definitionList.map((e) => TranslationWidget(
                                mh: mh,
                                mw: mw,
                                translationMap: e,
                              )),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              }),
        ),
      );
    });
  }
}
