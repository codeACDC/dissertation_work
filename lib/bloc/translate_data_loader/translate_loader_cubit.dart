import 'package:dissertation_work/bloc/translate_data_loader/data_loader/translate_loader.dart';
import 'package:dissertation_work/constants/constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'translate_loader_state.dart';

class TranslatorCubit extends Cubit<TranslatorState> {
  final String search;

  TranslatorCubit({required this.search}) : super(const TranslatorInitial());

  Future<void> translationParser() async {
    try {
      emit(const TranslatorLoading());
      final String url =
          'https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=${Constants.yandexDictApiKey}&lang=en-ru&text=$search';

      final translateLoader = TranslateLoader(url: url);
      final Map tempLoadedMap =  await translateLoader.translateLoader();

      emit(TranslatorLoaded(loadedTranslation: tempLoadedMap['def']));
    }
    catch (e){
      emit(TranslatorError(translationError: e.toString()));
    }
    
  }
}
