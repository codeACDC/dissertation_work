part of 'firebase_firestore_loader_cubit.dart';

abstract class FirebaseFirestoreState extends Equatable {
  const FirebaseFirestoreState();

  @override
  List<Object> get props => [];
}

class FirebaseFirestoreInitial extends FirebaseFirestoreState {
  const FirebaseFirestoreInitial();

  @override
  List<Object> get props => [];
}

class FirebaseFirestoreLoading extends FirebaseFirestoreState {
  const FirebaseFirestoreLoading();

  @override
  List<Object> get props => [];
}

class FirebaseFirestoreLoaded extends FirebaseFirestoreState {
  const FirebaseFirestoreLoaded();

  @override
  List<Object> get props => [];
}

class FirebaseFirestoreError extends FirebaseFirestoreState {
  final String error;
  const FirebaseFirestoreError(this.error);
  @override
  List<Object> get props => [error];
}