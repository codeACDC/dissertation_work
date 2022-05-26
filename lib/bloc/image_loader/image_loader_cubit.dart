import 'package:bloc/bloc.dart';
import 'package:dissertation_work/bloc/image_loader/model/data_loader.dart';
import 'package:equatable/equatable.dart';

part 'image_loader_state.dart';

class ImageLoaderCubit extends Cubit<ImageLoaderState> {
  final String searchText;
  ImageLoaderCubit({required this.searchText}) : super(const ImageLoaderInitial());

  Future<void> getPhotos() async {
    try {
      if(searchText.isNotEmpty)
      {
        emit(ImageLoaderLoading(searchText));

        final String currentUrl = 'https://pixabay.com/api/?key=26135823-6805a1b7eb2b4f15fe639b6de&q=$searchText';
        final dataLoader = DataLoader(currentUrl);
        final Map<String, dynamic> totalImageList = await dataLoader.jsonDataLoader();
        final List<String> currentImageList = [];

        for(int i = 0; i< 4; i++) {
          currentImageList.add(totalImageList['hits'][i]['webformatURL']);
        }
        emit(ImageLoaderLoaded(currentImageList));
      }
    }
    catch (e){
      emit(ImageLoaderError(e.toString()));
    }
}
}