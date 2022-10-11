import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dissertation_work/pages/achievement_page/achievement_page_widgets/carousel_indicator_widget.dart';
import 'package:dissertation_work/pages/page_of_translation/translation_page_widgets/translation_widget.dart';
import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/methods/methods.dart';
import '../../widgets/widgets.dart';

class MainHeroPage extends StatefulWidget {
  final String keyWord;
  final List totalList;
  final List imagesUrl;

  const MainHeroPage({
    Key? key,
    required this.keyWord,
    required this.imagesUrl,
    required this.totalList,
  }) : super(key: key);

  @override
  State<MainHeroPage> createState() => _MainHeroPageState();
}

class _MainHeroPageState extends State<MainHeroPage> {
  late int currentPhotoIndex;

  @override
  void initState() {
    currentPhotoIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double mh = MediaQuery.of(context).size.height;
    final double mw = MediaQuery.of(context).size.width;

    //Replace first letter of keyWord with upper letter
    final String tempKeyWord = widget.keyWord
        .replaceFirst(widget.keyWord[0], widget.keyWord[0].toUpperCase());

    return Scaffold(
        backgroundColor: ConstColor.blackBoard0C,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(giveH(size: 10, mh: mh)),
                  bottomLeft: Radius.circular(giveH(size: 10, mh: mh)))),
          title: flexTextWidget(
            text: tempKeyWord,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraint) {
            final double freeMh = constraint.maxHeight;
            final double freeMw = constraint.maxWidth;
            return Container(
              width: freeMw,
              height: freeMh,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: giveH(size: 10, mh: freeMh),
                      horizontal: giveW(size: 20, mw: freeMw)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.imagesUrl.isEmpty
                          ? Container()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Hero(
                                  tag: widget.keyWord,
                                  child: CarouselSlider.builder(
                                      itemCount: widget.imagesUrl.length,
                                      itemBuilder: (context, index, page) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: giveH(size: 5, mh: mh)),
                                          height: giveH(size: 50, mh: freeMh),
                                          width: giveW(size: 270, mw: mw),
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.6),
                                                    spreadRadius:
                                                        giveH(size: 2, mh: mh),
                                                    blurRadius:
                                                        giveH(size: 3, mh: mh),
                                                    offset:
                                                        Offset.fromDirection(
                                                            -3)),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(giveH(
                                                      size: 10, mh: freeMh)),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: MemoryImage(
                                                      Uint8List.fromList(widget
                                                          .imagesUrl
                                                          .elementAt(index))))),
                                        );
                                      },
                                      options: CarouselOptions(
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, _) {
                                            super.setState(() {
                                              currentPhotoIndex = index;
                                            });
                                          })),
                                ),
                                CarouselIndicatorWidget(
                                  mh: mh,
                                  mw: mw,
                                  totalQuantityOfPhoto: widget.imagesUrl.length,
                                  currentPhotoIndex: currentPhotoIndex,
                                ),
                              ],
                            ),
                      //Make from _InternalLinkedHashMap<dynamic, dynamic> to Map<String, dynamic>
                      TranslationWidget(
                          mh: freeMh, mw: freeMw, translation: widget.totalList)
                    ],
                  ),
                ),
              ),
            );
          }),
        ));
  }
}
