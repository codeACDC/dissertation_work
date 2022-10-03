import 'package:dissertation_work/bloc/translate_data_loader/data_loader/translate_loader.dart';
import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/widgets/translations_inherited.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

part 'translate_loader_state.dart';

class TranslatorCubit extends Cubit<TranslatorState> {
  final String search;
  final List imagesUrl;
  final BuildContext context;

  TranslatorCubit({required this.search, required this.imagesUrl, required this.context})
      : super(const TranslatorInitial());

  Future<void> toBinaryDataConverter({required List imagesUrl}) async {
    List binaryListOfImages = [];
    for (int i = 0; i < imagesUrl.length; i++) {
      Response response = await get(Uri.parse(imagesUrl[i]));
      binaryListOfImages.add(response.bodyBytes);
    }
    Future.delayed(Duration.zero,() {
      TranslationInherited.of(context).binaryListOfImages = binaryListOfImages;
    },);
  }

  Future<void> translationParser() async {
    try {
      emit(const TranslatorLoading());
      final String url =
          'https://el-sozduk.kg/$search/';

      final translateLoader = TranslateLoader(url: url);
      final List tempLoaded = await translateLoader.translateLoader();

      await toBinaryDataConverter(imagesUrl: imagesUrl);
      emit(TranslatorLoaded(loadedTranslation: tempLoaded));
    }
    catch (e) {
      emit(TranslatorError(translationError: e.toString()));
    }
  }
}
