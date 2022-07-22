import 'package:cached_network_image/cached_network_image.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/widgets/models/image_model.dart';
import 'package:dissertation_work/widgets/replace_inherited_widget.dart';
import 'package:flutter/material.dart';

class GridOfImage extends StatefulWidget {
  final double mh;
  final double mw;
  final List<String> urlsOfImage;

  const GridOfImage({
    Key? key,
    required this.mh,
    required this.mw,
    required this.urlsOfImage,
  }) : super(key: key);

  @override
  State<GridOfImage> createState() => _GridOfImageState();
}

class _GridOfImageState extends State<GridOfImage> {
  late List<ImageModel> imageModelList;
  late List<Widget> stackChildrenList;

  static const List<Alignment> _alignmentList = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomLeft,
    Alignment.bottomRight
  ];

  @override
  void initState() {
    imageModelList = widget.urlsOfImage
        .map((e) => ImageModel(url: e, index: widget.urlsOfImage.indexOf(e)))
        .toList();
    stackChildrenList = imageModelList
        .map((e) => _cachedImageWidget(context,
            mh: widget.mh,
            mw: widget.mw,
            imageModel: e,
            alignment: _alignmentList[imageModelList.indexOf(e)]))
        .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ReplaceInherited.of(context).stackChildrenList = stackChildrenList;

    return Stack(
      children: ReplaceInherited.of(context).stackChildrenList!,
    );
  }
}

Widget _cachedImageWidget(
  BuildContext context, {
  required double mh,
  required double mw,
  required Alignment alignment,
  required ImageModel imageModel,
}) {
  return LayoutBuilder(builder: (context, constraints) {
    double freeMh = constraints.maxHeight;
    double freeMw = constraints.maxWidth;
    return Align(
      alignment: alignment,
      child: CachedNetworkImage(
          imageBuilder: (context, provider) => AnimatedContainer(
                width: imageModel.isTap ? freeMw : giveW(size: 180, mw: mw),
                height: imageModel.isTap ? freeMh : giveH(size: 97, mh: mh),
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                    image: DecorationImage(fit: BoxFit.cover, image: provider),
                    borderRadius:
                        BorderRadius.circular(giveH(size: 10, mh: mh))),
                child: Material(
                  color: Colors.white.withOpacity(0.0),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(giveH(size: 10, mh: mh)),
                    onTap: () {
                      ReplaceInherited.of(context)
                          .replaceStackChildren(imageModel);
                    },
                  ),
                ),
              ),
          imageUrl: imageModel.url,
          errorWidget: (context, url, error) => const Icon(
                Icons.error,
                color: Colors.red,
              ),
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return Padding(
              padding: EdgeInsets.all(giveH(size: 37, mh: mh)),
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: Colors.deepPurple[800],
              ),
            );
          }),
    );
  });
}
