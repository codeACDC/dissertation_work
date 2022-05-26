part of 'image_loader_cubit.dart';

abstract class ImageLoaderState extends Equatable {
  const ImageLoaderState();

  @override
  List<Object> get props => [];
}

class ImageLoaderInitial extends ImageLoaderState {
  const ImageLoaderInitial();
}

class ImageLoaderLoading extends ImageLoaderState {
  final String searchText;
  const ImageLoaderLoading(this.searchText);

  @override
  List<Object> get props => [searchText];
}

class ImageLoaderLoaded extends ImageLoaderState {
  final List<String> loadedImages;
  const ImageLoaderLoaded(this.loadedImages);

  @override
  List<Object> get props => [loadedImages];
}

class ImageLoaderError extends ImageLoaderState {
  final String errorMessage;
  const ImageLoaderError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
