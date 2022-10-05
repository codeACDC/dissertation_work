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
    if (siteModelList.isEmpty) {
      for (int i = 0; i < widget.translation[2].length; i++) {
        setState(() {
          siteModelList.add(SiteModel(
              article: widget.translation[0][i],
              contentSource: widget.translation[1][i],
              content: widget.translation[2][i]));
        });
      }

    }
    final double mh = widget.mh;
    final double mw = widget.mw;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: siteModelList
            .map((e) =>
            Padding(
              padding: EdgeInsets.only(bottom: giveH(size: 5, mh: mh), top: giveH(size: 10, mh: mh)),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
              Container(
                padding: EdgeInsets.all(giveH(size: 10, mh: mh)),
                width: mw,
              decoration: BoxDecoration(
              color: ConstColor.translationText,
                  borderRadius: BorderRadius.only(
                      topRight:
                      Radius.circular(giveH(size: 15, mh: mh)))),
              child: Text(
                e.article.toLowerCase(),
                style: TextStyle(
                    color: ConstColor.blackBoard0C,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    fontSize: giveH(size: 16, mh: mh)),
              ),
            ),
          Wrap(children: [
            Container(
              padding: EdgeInsets.all(giveH(size: 10, mh: mh)),
              decoration: const BoxDecoration(
                color: ConstColor.blackBoard0C,
              ),
              child: Text(
                e.contentSource,
                style: TextStyle(
                    color: ConstColor.translationText,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    fontSize: giveH(size: 14, mh: mh)),
              ),
            )
          ]), Wrap(children: [
            Container(
              padding: EdgeInsets.all(giveH(size: 10, mh: mh)),
              width: mw,
                decoration: BoxDecoration(
                  color: ConstColor.blackBoard0C,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(giveH(size: 15, mh: mh))
                  )),
                  child: Text(
                    e.content,
                    style: TextStyle(
                        color: ConstColor.translationText,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        fontSize: giveH(size: 12, mh: mh)),
                  ),
                )
                ]),
          ],
          ),
        ))
        .toList());
  }
}

class SiteModel {
  final String article;
  final String contentSource;
  final String content;

  const SiteModel({required this.article,
    required this.contentSource,
    required this.content});
}
