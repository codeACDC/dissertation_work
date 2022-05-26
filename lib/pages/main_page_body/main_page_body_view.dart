import 'package:cached_network_image/cached_network_image.dart';
import 'package:dissertation_work/bloc/image_loader/image_loader_cubit.dart';
import 'package:dissertation_work/pages/main_page_body/grid_of_image.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../constants/methods/methods.dart';

import '../../widgets/custom_widget.dart';
import '../../widgets/models/letter_model.dart';
import '../../widgets/models/replace_model.dart';
import '../../widgets/replace_inherited_widget.dart';

class MainPageBody extends StatefulWidget {
  const MainPageBody({Key? key}) : super(key: key);

  @override
  State<MainPageBody> createState() => _MainPageBodyState();
}

class _MainPageBodyState extends State<MainPageBody> {
  late Map<LetterClass, List<dynamic>> saveIndexArray;
  late List<LetterClass> randomLetterList;
  late List<LetterClass> emptyStringList;

  @override
  void initState() {
    //Preparation data
    List<String> tempRandomLetterList =
        Constants.keyWords[0].toUpperCase().split('');

    tempRandomLetterList.addAll(Constants.alphabetList.where((elem) =>
        !tempRandomLetterList.contains(elem) &&
        tempRandomLetterList.length < 12));
    tempRandomLetterList.shuffle();

    List<String> tempEmptyStringList =
        List<String>.filled(Constants.keyWords[0].length, '');

    //Preparation LetterClass List
    saveIndexArray = {};

    randomLetterList = tempRandomLetterList
        .map((e) => LetterClass(
              letter: e,
              id: UniqueKey().toString(),
            ))
        .toList();

    emptyStringList = tempEmptyStringList
        .map((e) => LetterClass(
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

          ReplaceInherited.of(context).randomLetterListSetter =
              randomLetterList;
          ReplaceInherited.of(context).emptyStringListSetter = emptyStringList;
          ReplaceInherited.of(context).saveIndexArraySetter = saveIndexArray;
          ReplaceInherited.of(context).keyWordSetter = Constants.keyWords[0];

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
                    ImageLoaderCubit(searchText: Constants.keyWords[0])
                      ..getPhotos(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: giveH(size: 10, mh: mh)),
                        child: BlocBuilder<ImageLoaderCubit, ImageLoaderState>(
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
                                return GridOfImage(
                                    mh: mh,
                                    mw: mw,
                                    urlsOfImage: state.loadedImages);
                              }
                              if (state is ImageLoaderError) {
                                Future.delayed(Duration.zero, () async {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    state.errorMessage,
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  )));
                                });
                              }
                              return Container();
                            }),
                      ),
                    ),

                    //Empty widget list
                    Container(
                      width: mw,
                      margin: EdgeInsets.symmetric(
                          vertical: giveH(size: 10, mh: mh)),
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: ReplaceInherited.of(context)
                              .emptyStringList!
                              .map((e) => CustomWidget(
                                    mw: mw,
                                    mh: mh,
                                    letterElem: e,
                                  ))
                              .toList(),
                        ),
                      ),
                    ),

                    //Letter widget list
                    Container(
                      height: giveH(size: 79, mh: mh),
                      margin: EdgeInsets.symmetric(
                          vertical: giveH(size: 10, mh: mh)),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ReplaceInherited.of(context)
                            .randomLetterList!
                            .length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6),
                        itemBuilder: (context, index) {
                          return CustomWidget(
                            mw: mw,
                            mh: mh,
                            letterElem: ReplaceInherited.of(context)
                                .randomLetterList![index],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
