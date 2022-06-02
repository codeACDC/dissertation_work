import 'package:dissertation_work/bloc/translate_data_loader/translate_loader_cubit.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/page_of_translation/translation_page_widgets/translation_widget.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/constants.dart';

class TranslationPageBody extends StatelessWidget {
  final String keyWord;

  const TranslationPageBody({Key? key, required this.keyWord})
      : super(key: key);

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
              TranslatorCubit(search: keyWord)..translationParser(),
          child: BlocBuilder<TranslatorCubit, TranslatorState>(
              buildWhen: (previousState, currentState) =>
                  previousState != currentState,
              builder: (context, state) {
                if (state is TranslatorError) {
                  Future.delayed(
                    Duration.zero,
                    () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(seconds: 10),
                          backgroundColor: Colors.deepPurple[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  giveH(size: 10, mh: mh))),
                          content: SizedBox(
                            height: giveH(size: 50, mh: mh),
                            child: flexTextWidget(
                                boxFit: BoxFit.contain,
                                text: state.translationError,
                                fontSize: giveH(size: 25, mh: mh),
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          )));
                    },
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
                  final List definitionList = state.loadedTranslation;
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
                              mh: mh, mw: mw, translationMap: e)),
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
