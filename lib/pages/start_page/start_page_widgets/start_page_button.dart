import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/main_page/drawer/exit_widget.dart';
import 'package:dissertation_work/pages/main_page/main_page.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';

class StartPageButton extends StatelessWidget {
  final double mh;
  final double mw;
  final String title;
  final String route;
  final IconData icon;

  const StartPageButton({
    Key? key,
    required this.mh,
    required this.mw,
    required this.title,
    required this.route,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: giveH(size: 5, mh: mh)),
      height: giveH(size: 30, mh: mh),
      decoration: BoxDecoration(
          color: ConstColor.blackBoard0C,
          borderRadius: BorderRadius.circular(giveH(size: 7, mh: mh)),
          boxShadow: [
            BoxShadow(
              color: ConstColor.containerBorder,
              spreadRadius: giveW(size: 3, mw: mw),
              blurRadius: giveW(size: 4, mw: mw),
            )
          ]),
      child: Material(
        color: Colors.black.withOpacity(0.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(giveH(size: 7, mh: mh)),
          onTap: () {
            if (route != '/') {
              if (route == MainPage.id) {
                Navigator.of(context).pushReplacementNamed(route);
              }
              else if(route == ExitWidget.id) {
                onBackButtonPressed(context);
              }
              else {
                Navigator.of(context).pushNamed(route);
              }
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: giveW(size: 10, mw: mw)),
              Icon(icon, color: ConstColor.translationText,size: giveH(size: 17, mh: mh),),
              SizedBox(width: giveW(size: 15, mw: mw)),
              flexTextWidget(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: giveH(size: 18, mh: mh),
                color: Colors.white,
              ),
              SizedBox(width: giveW(size: 10, mw: mw)),
            ],
          ),
        ),
      ),
    );
  }
}
