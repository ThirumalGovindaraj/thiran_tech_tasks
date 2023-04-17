import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/firebase/firebase_repository.dart';
import 'package:tasks/utilities/firebase_utils.dart';

import '../github/error_response.dart';
import 'firebase_request.dart';

class FirebaseBloc extends Bloc<FirebaseEvent, FirebaseState> {
  final FirebaseRepository _repository = FirebaseRepository();

  FirebaseBloc(FirebaseInitial transactionInitial) : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {
      emit(FirebaseLoading());
    });
    on<OnFirebaseSaveEvent>((event, emit) async {
      if (event.firebase.attachment != null &&
          event.firebase.attachment!.isNotEmpty) {
        var downloadURL =
            await FirebaseUtils.uploadPicture(File(event.firebase.attachment!));
        event.firebase.attachment = downloadURL;
        dynamic response =
            await FirebaseUtils.saveBugReport(event.firebase, event.userId);
        if (response is bool && response) {
          Future.delayed(const Duration(seconds: 30), () async {
            debugPrint("Calling FCM request");
            var fcmRequest = await _repository.requestFCM(event.firebase);
            debugPrint("Calling FCM Response $fcmRequest");
          });
          emit(FirebaseSaved());
        } else {
          emit(FirebaseError(response));
        }
      } else {
        dynamic response =
            await FirebaseUtils.saveBugReport(event.firebase, event.userId);
        if (response is bool && response) {
          emit(FirebaseSaved());
        } else {
          emit(FirebaseError(response));
        }
      }
    });
    on<OnFormLoadEvent>((event, emit) async {
      emit(NewFormFirebase());
    });
  }
}

/// Firebase States

abstract class FirebaseState extends Equatable {
  const FirebaseState();

  @override
  List<Object?> get props => [];
}

class FirebaseInitial extends FirebaseState {}

class FirebaseLoading extends FirebaseState {}

class FirebaseLoaded extends FirebaseState {
  List<FirebaseRequest> FirebaseList;

  FirebaseLoaded(this.FirebaseList);
}

class TextFirebaseLoaded extends FirebaseState {
  const TextFirebaseLoaded();
}

class FirebaseError extends FirebaseState {
  final String error;

  const FirebaseError(this.error);
}

class FirebaseSaved extends FirebaseState {}

class NewFormFirebase extends FirebaseState {}

///Firebase Events
///
abstract class FirebaseEvent {}

class PageOnLoadEvent extends FirebaseEvent {
  PageOnLoadEvent();
}

class OnFormLoadEvent extends FirebaseEvent {
  OnFormLoadEvent();
}

class OnFirebaseSaveEvent extends FirebaseEvent {
  FirebaseRequest firebase;
  String userId;

  OnFirebaseSaveEvent({required this.firebase, required this.userId});
}

class OnFirebaseLoadEvent extends FirebaseEvent {}
