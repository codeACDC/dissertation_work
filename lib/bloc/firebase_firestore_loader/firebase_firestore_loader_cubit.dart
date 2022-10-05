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

      final data = await FirebaseFirestore.instance
          .collection(Constants.firebaseCompetitionCollectionName)
          .doc(Constants.firebaseKeyWordDocName)
          .get();

      var fireBaseDataValues = data.data()!.values;
      debugPrint('Firebase data: $fireBaseDataValues');

      var fireBaseBox = Hive.box(Constants.fireBaseBox);
      if (fireBaseDataValues.length > fireBaseBox.length) {
        if (fireBaseBox.length > 0) {
          fireBaseBox.deleteAll(fireBaseBox.keys);
        }
        var tempFireBaseBoxValues = [];
        for (int i = 0; i < fireBaseDataValues.length; i++) {
          tempFireBaseBoxValues.add(FireBaseAnswerModel(
            kgKeyWord: fireBaseDataValues.elementAt(i).elementAt(0),
            enKeyWord: fireBaseDataValues.elementAt(i).elementAt(1),
          ));
        }
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
