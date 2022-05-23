import 'package:cached_network_image/cached_network_image.dart';
import 'package:dissertation_work/bloc/image_loader/image_loader_cubit.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<ImageLoaderCubit, ImageLoaderState>(
                    builder: (context, state) {
                  if (state is ImageLoaderLoading) {
                    return CircularProgressIndicator(
                      color: Colors.deepPurple[800],
                    );
                  }
                  if (state is ImageLoaderLoaded) {
                    return SizedBox(
                      height: giveH(size: 100, mh: mh),
                      child: GridView.builder(
                        itemCount: state.loadedImages.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(imageUrl: state.loadedImages[index]);
                          }),
                    );
                  }
                  if (state is ImageLoaderError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      state.errorMessage,
                      style: Theme.of(context).textTheme.headline3,
                    )));
                  }
                  return Container();
                }),
                SizedBox(
                  width: mw,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: giveW(size: 15, mw: mw),
                      ),
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
                ),
                Container(
                  height: giveH(size: 79, mh: mh),
                  margin: EdgeInsets.only(
                      bottom: giveH(size: 30, mh: mh),
                      top: giveH(size: 30, mh: mh)),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        ReplaceInherited.of(context).randomLetterList!.length,
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
          );
        },
      ),
    );
  }
}
