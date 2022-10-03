import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class TranslationWidget extends StatefulWidget {
  final double mh;
  final double mw;
  final List translation;

  const TranslationWidget({
    Key? key,
    required this.mh,
    required this.mw,
    required this.translation,
  }) : super(key: key);

  @override
  State<TranslationWidget> createState() => _TranslationWidgetState();
}

class _TranslationWidgetState extends State<TranslationWidget> {
  List<SiteModel> siteModelList = [];

  @override
  Widget build(BuildContext context) {
    if (siteModelList.isNotEmpty) {
      for (int i = 0; i < widget.translation[2].length; i++) {
        siteModelList.add(SiteModel(
            article: widget.translation[0][i],
            contentSource: widget.translation[1][i],
            content: widget.translation[2][i]));
      }
      setState(() {
        siteModelList;
      });
    }
    final double mh = widget.mh;
    final double mw = widget.mw;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: siteModelList
            .map((e) => Padding(
                  padding: EdgeInsets.only(bottom: giveH(size: 3, mh: mh)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ConstColor.translationText,
                            borderRadius: BorderRadius.only(
                                topRight:
                                    Radius.circular(giveH(size: 5, mh: mh)))),
                        child: Text(
                          e.article,
                          style: TextStyle(
                              color: ConstColor.blackBoard0C,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              fontSize: giveH(size: 16, mh: mh)),
                        ),
                      ),
                      Wrap(
                        children: [
                          Container(decoration:BoxDecoration(color: ConstColor.blackBoard0C,))
                      ])],
                  ),
                ))
            .toList());
  }
}

class SiteModel {
  final String article;
  final String contentSource;
  final String content;

  const SiteModel(
      {required this.article,
      required this.contentSource,
      required this.content});
}
