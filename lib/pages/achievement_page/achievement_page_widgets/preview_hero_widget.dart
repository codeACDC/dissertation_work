
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/achievement_page/main_hero_page.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PreviewHeroWidget extends StatelessWidget {
  final double mh;
  final double mw;
  final List totalList;
  final List imagesUrl;
  final String keyWord;

  const PreviewHeroWidget({
    Key? key,
    required this.mh,
    required this.mw,
    required this.totalList,
    required this.imagesUrl,
    required this.keyWord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //make first letter of keyWord in upper case
    String tempKeyWord =
        keyWord.replaceFirst(keyWord[0], keyWord[0].toUpperCase());
    return DecoratedBox(
      decoration: BoxDecoration(
          // border: Border.all(color: ConstColor.translationText),
          boxShadow: [
            BoxShadow(
                blurRadius: giveW(size: 3, mw: mw),
                spreadRadius: giveW(size: 0.9, mw: mw),
                offset: const Offset(0.2, 1))
          ],
          color: ConstColor.translationContainerBG,
          borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh))),
      child: Hero(
        tag: keyWord,
        transitionOnUserGestures: true,
        child: Material(
          borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh)),
          color: Colors.white.withOpacity(0.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh)),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return MainHeroPage(
                    keyWord: keyWord,
                    imagesUrl: imagesUrl,
                    totalList: totalList);
              }));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //aspect ratio of image
                CachedNetworkImage(
                  imageUrl: imagesUrl.first,
                  fit: BoxFit.cover,
                  imageBuilder: (context, provider) {
                    return Container(
                        decoration: BoxDecoration(
                            color: ConstColor.translationContainerBG,
                            // border: Border.all(color: ConstColor.translationText),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(giveH(size: 10, mh: mh)),
                              topRight:
                                  Radius.circular(giveH(size: 10, mh: mh)),
                            ),
                            image: DecorationImage(
                                image: provider, fit: BoxFit.cover)));
                  },
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                  progressIndicatorBuilder: (context, url, progress) => Center(
                      child: CircularProgressIndicator(
                    color: Colors.deepPurple[800],
                    value: progress.progress,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: giveH(size: 3, mh: mh)),
                  child: flexTextWidget(
                    text: tempKeyWord,
                    fontSize: giveH(size: 10, mh: mh),
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
