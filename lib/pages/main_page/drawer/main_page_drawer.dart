import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/hint_page/hint_page.dart';
import 'package:dissertation_work/pages/main_page/drawer/exit_widget.dart';
import 'package:dissertation_work/pages/start_page/start_page.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MainPageDrawer extends StatelessWidget {
  final double mh;
  final double mw;

  const MainPageDrawer({Key? key, required this.mw, required this.mh})
      : super(key: key);

  final List<DrawerListTileModel> tileModelList = const [
    DrawerListTileModel(
      title: 'Главное меню',
      leadingIcon: Icons.home,
      routeId: StartPage.id,
    ),
    DrawerListTileModel(
      title: 'Подсказки',
      leadingIcon: Icons.help_outline,
      routeId: HintPage.id,
    ),
    DrawerListTileModel(
      title: 'Выход',
      leadingIcon: Icons.exit_to_app,
      routeId: ExitWidget.id,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ConstColor.blackBoard0C,
      child: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: giveW(size: 20, mw: mw),
            vertical: giveH(size: 10, mh: mh)),
        physics: const BouncingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: giveH(size: 10, mh: mh)),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: ConstColor.translationContainerBG,
                  borderRadius: BorderRadius.circular(giveH(size: 5, mh: mh))),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: ConstColor.translationText,
                      size: giveH(size: 17, mh: mh),
                    ),
                  ),
                  SizedBox(
                    width: giveW(size: 30, mw: mw),
                  ),
                  flexTextWidget(
                    text: 'Меню',
                    fontSize: giveH(size: 20, mh: mh),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          ...tileModelList.map((e) => DrawerListTile(
                mh: mh,
                mw: mw,
                title: e.title,
                leadingIcon: e.leadingIcon,
                routeId: e.routeId,
              )),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final double mh;
  final double mw;
  final String title;
  final IconData leadingIcon;
  final String routeId;

  const DrawerListTile({
    Key? key,
    required this.mh,
    required this.mw,
    required this.title,
    required this.leadingIcon,
    required this.routeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String tempTitle = title;
    if (title.length < 6) {
      tempTitle = title + ' ' * (9 - title.length);
    }
    return Container(
      margin: EdgeInsets.all(giveH(size: 5, mh: mh)),
      child: ListTile(
        tileColor: ConstColor.translationContainerBG,
        leading: Icon(
          leadingIcon,
          color: ConstColor.translationText,
        ),
        title: flexTextWidget(
            text: tempTitle,
            color: Colors.white,
            fontSize: giveH(size: 11, mh: mh)),
        contentPadding:
            EdgeInsets.symmetric(horizontal: giveH(size: 5, mh: mh)),
        shape: RoundedRectangleBorder(
            // side: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(giveH(size: 10, mh: mh))),
        onTap: () {
          if (routeId == '/') {
            Navigator.of(context).pop();
          } else if (routeId == StartPage.id) {
            Navigator.of(context).pushReplacementNamed(routeId);
          } else if (routeId == ExitWidget.id) {
            onBackButtonPressed(context);
          } else {
            Navigator.of(context).pushNamed(routeId);
          }
        },
      ),
    );
  }
}

class DrawerListTileModel {
  final String title;
  final IconData leadingIcon;
  final String routeId;

  const DrawerListTileModel({
    required this.title,
    required this.leadingIcon,
    this.routeId = '/',
  });
}
