import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/firebase/firebase_repository.dart';
import 'package:tasks/utilities/firebase_utils.dart';

import '../../utilities/database_utils.dart';
import '../github/error_response.dart';
import '../firebase/firebase_request.dart';

class FirebaseListBloc extends Bloc<FirebaseListEvent, FirebaseListState> {
  final FirebaseRepository _repository = FirebaseRepository();

  FirebaseListBloc(FirebaseListInitial transactionInitial) : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {
      emit(FirebaseListLoading());
    });
    on<OnFetchFirebaseEvent>((event, emit) async {
      dynamic response = await FirebaseUtils.getBugReport(event.userId);
      // debugPrint(response);
      if(response is List<FirebaseRequest>) {
        emit(FirebaseListLoaded(response));
      }else{
        emit(FirebaseListError(response));
      }
    });
  }
}

/// FirebaseList States

abstract class FirebaseListState extends Equatable {
  const FirebaseListState();

  @override
  List<Object?> get props => [];
}

class FirebaseListInitial extends FirebaseListState {}

class FirebaseListLoading extends FirebaseListState {}

class FirebaseListLoaded extends FirebaseListState {
  List<FirebaseRequest> firebaseList;

  FirebaseListLoaded(this.firebaseList);
}


class FirebaseListError extends FirebaseListState {
  final dynamic error;

  const FirebaseListError(this.error);
}



///FirebaseList Events
///
abstract class FirebaseListEvent {}

class PageOnLoadEvent extends FirebaseListEvent {
  PageOnLoadEvent();
}

class OnFetchFirebaseEvent extends FirebaseListEvent {
  final String userId;
  OnFetchFirebaseEvent({required this.userId});
}



class OnFirebaseListLoadEvent extends FirebaseListEvent {}
