import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dissertation_work/constants/constants.dart';
import 'package:dissertation_work/widgets/models/firebase_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'firebase_firestore_loader_state.dart';

class FirebaseFirestoreCubit extends Cubit<FirebaseFirestoreState> {
  FirebaseFirestoreCubit() : super(const FirebaseFirestoreInitial());

  Future<void> loadDataFromFirebase() async {
    try {
      emit(const FirebaseFirestoreLoading());
      final internetConnectionQuery =
          await InternetAddress.lookup('google.com');

      if (internetConnectionQuery.isNotEmpty &&
          internetConnectionQuery[0].rawAddress.isNotEmpty) {
        debugPrint('Connected');
      }

      var documentSnapshot = FirebaseFirestore.instance
          .collection(Constants.firebaseCompetitionCollectionName)
          .doc(Constants.firebaseKeyWordDocName);

      // await documentSnapshot.set(Constants.translatedData).then((value) => debugPrint('Data sent,ok!'));
      final data = await documentSnapshot.get();

      var fireBaseDataValues = data.data()!;
      debugPrint(
          'Колличество загруженных слов в онлайн базу данных: ${fireBaseDataValues.length}');

      var fireBaseBox = Hive.box(Constants.fireBaseBox);
      if (fireBaseDataValues.length > fireBaseBox.length) {
        if (fireBaseBox.length > 0) {
          fireBaseBox.deleteAll(fireBaseBox.keys);
        }
        var tempFireBaseBoxValues = [];
        for (int i = 0; i < fireBaseDataValues.length; i++) {
          if(fireBaseDataValues.values.elementAt(i).toString().length <= 12) {
            tempFireBaseBoxValues.add(FireBaseAnswerModel(
            kgKeyWord:
                fireBaseDataValues.values.elementAt(i).toString().toLowerCase(),
            enKeyWord:
                fireBaseDataValues.keys.elementAt(i).toString().toLowerCase(),
          ));
          }
        }
        debugPrint('Длина списка загружаемого в локальную базу данных: ${tempFireBaseBoxValues.length}');

        fireBaseBox.addAll(tempFireBaseBoxValues);

        // for(var elem in fireBaseData) {
        //   if(!fireBaseBox.values.contains(elem)) {
        //     fireBaseBox.add(elem);
        //   }
        // }
      }
      emit(const FirebaseFirestoreLoaded());
    } on SocketException catch (_) {
      emit(const FirebaseFirestoreError('No internet connection'));
    } catch (error) {
      debugPrint(error.toString());
      emit(FirebaseFirestoreError(error.toString()));
    }
  }
}
