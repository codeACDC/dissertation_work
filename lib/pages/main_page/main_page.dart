import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/constants/methods/methods.dart';
import 'package:dissertation_work/pages/main_page/drawer/main_page_drawer.dart';
import 'package:dissertation_work/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:just_audio/just_audio.dart';

import '../main_page/main_page_body/main_page_body_view.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const id = 'main_page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final AudioPlayer audioPlayer = AudioPlayer();
  var soundVolumeStateBox = Hive.box(Constants.soundVolumeStateBox);

  late bool isMute;

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  @override
  void initState() {
    isMute = soundVolumeStateBox.isNotEmpty
        ? soundVolumeStateBox.values.last
        : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double mh = MediaQuery.of(context).size.height;
    double mw = MediaQuery.of(context).size.width;
    doSoundMute(audioPlayer: audioPlayer, isMute: isMute);

    return WillPopScope(
      onWillPop: () => onBackButtonPressed(context),
      child: Scaffold(
        backgroundColor: ConstColor.blackBoard0C,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(giveH(size: 10, mh: mh)),
              bottomRight: Radius.circular(giveH(size: 10, mh: mh)),
            ),
          ),
          title: flexTextWidget(
            text: 'Word finder',
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  super.setState(() {
                    isMute = !isMute;
                  });
                  soundVolumeStateBox.add(isMute);
                },
                icon: Icon(
                  isMute ? Icons.volume_mute : Icons.volume_down,
                  size: giveH(size: 16, mh: mh),
                ))
          ],
        ),
        drawer: MainPageDrawer(mw: mw, mh: mh),
        body: SafeArea(child: MainPageBody(audioPlayer: audioPlayer)),
      ),
    );
  }
}
