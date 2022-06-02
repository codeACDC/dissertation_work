part of 'translate_loader_cubit.dart';

@immutable
abstract class TranslatorState extends Equatable {
  const TranslatorState();

  @override
  List<Object> get props => [];
}

class TranslatorInitial extends TranslatorState {
  const TranslatorInitial();
  @override
  List<Object> get props => [];
}

class TranslatorLoading extends TranslatorState {
  const TranslatorLoading();
  @override
  List<Object> get props => [];
}

class TranslatorLoaded extends TranslatorState {
  final List loadedTranslation;
  const TranslatorLoaded({required this.loadedTranslation});

  @override
  List<Object> get props => [loadedTranslation];
}

class TranslatorError extends TranslatorState {
  final String translationError;
  const TranslatorError({required this.translationError});

  @override
  List<Object> get props => [translationError];
}