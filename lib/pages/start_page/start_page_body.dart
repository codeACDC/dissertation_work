import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/achievement_page/achievement_page.dart';
import 'package:dissertation_work/pages/hint_page/hint_page.dart';
import 'package:dissertation_work/pages/main_page/main_page.dart';
import 'package:dissertation_work/pages/start_page/start_page_widgets/start_page_button.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/firebase_firestore_loader/firebase_firestore_loader_cubit.dart';
import '../../constants/constants.dart';
import '../main_page/drawer/exit_widget.dart';

class StartPageBody extends StatelessWidget {
  const StartPageBody({Key? key}) : super(key: key);
  static const List<StartPageButtonModel> startButtonTitles = [
    StartPageButtonModel(
        title: 'Оюнду баштоо',
        route: MainPage.id,
        icon: Icons.directions_run_sharp),
    StartPageButtonModel(
        title: 'Жетишкендиктер',
        route: AchievementPage.id,
        icon: Icons.system_security_update_good_rounded),
    StartPageButtonModel(
        title: 'Кеңешмелер',
        route: HintPage.id,
        icon: Icons.help_outline),
    StartPageButtonModel(
        title: 'Чыгуу', route: ExitWidget.id, icon: Icons.exit_to_app),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: LayoutBuilder(builder: (context, constraints) {
      double mh = constraints.maxHeight;
      double mw = constraints.maxWidth;
      return Container(
        height: mh,
        width: mw,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [ConstColor.blackBoard0C, ConstColor.greyBoard31],
        )),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              SizedBox(
                height: giveH(size: 60, mh: mh),
              ),
              AnimatedTextKit(totalRepeatCount: 1, animatedTexts: [
                WavyAnimatedText(
                  'Сөздү тап!',
                  speed: const Duration(milliseconds: 150),
                  textStyle: TextStyle(
                      fontSize: giveH(size: 25, mh: mh),
                      color: ConstColor.translationText,
                      fontWeight: FontWeight.w600),
                )
              ]),
              SizedBox(
                height: giveH(size: 40, mh: mh),
              ),
              BlocProvider<FirebaseFirestoreCubit>(
                create: (context) =>
                    FirebaseFirestoreCubit()..loadDataFromFirebase(),
                child:
                    BlocBuilder<FirebaseFirestoreCubit, FirebaseFirestoreState>(
                        buildWhen: (previousState, currentState) =>
                            previousState != currentState,
                        builder: (context, state) {
                          if (state is FirebaseFirestoreLoaded) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ...startButtonTitles.map((e) => StartPageButton(
                                      mh: mh,
                                      mw: mw,
                                      title: e.title,
                                      route: e.route,
                                      icon: e.icon,
                                    ))
                              ],
                            );
                          }
                          if (state is FirebaseFirestoreLoading) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            );
                          }
                          if (state is FirebaseFirestoreError) {
                            return Center(
                              child: MaterialButton(
                                elevation: giveH(size: 3, mh: mh),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      giveH(size: 5, mh: mh)),
                                ),
                                onPressed: () {
                                  context
                                      .read<FirebaseFirestoreCubit>()
                                      .loadDataFromFirebase();
                                },
                                color: Colors.deepPurple[800],
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.repeat,
                                      color: Colors.white,
                                    ),
                                    flexTextWidget(
                                        text: '  Кайталоо',
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400)
                                  ],
                                ),

                              ),
                            );
                          }
                          return Container();
                        }),
              )
            ]),
          ),
        ),
      );
    }));
  }
}

class StartPageButtonModel {
  final String title;
  final String route;
  final IconData icon;

  const StartPageButtonModel(
      {required this.title, required this.route, required this.icon});
}
