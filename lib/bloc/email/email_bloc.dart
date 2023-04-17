import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utilities/database_utils.dart';
import '../github/error_response.dart';
import 'email.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc(EmailInitial transactionInitial) : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {
      dynamic response = await DBProvider.db.getAllEmail();
      if (response is List<EmailRequest>) {
        emit(EmailLoaded(response));
      } else {
        emit(EmailError(response));
      }
    });
    on<OnEmailSaveEvent>((event, emit) async {
      dynamic response = await DBProvider.db.newEmail(event.email);
      if (response is int) {
        emit(EmailSaved());
      } else {
        emit(EmailError(response));
      }
    });
    on<OnFormLoadEvent>((event, emit) async {
      emit(NewFormEmail());
    });
  }
}

/// Email States

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object?> get props => [];
}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailLoaded extends EmailState {
  List<EmailRequest> emailList;

  EmailLoaded(this.emailList);
}

class TextEmailLoaded extends EmailState {
  const TextEmailLoaded();
}

class EmailError extends EmailState {
  final ErrorResponse error;

  const EmailError(this.error);
}

class EmailSaved extends EmailState {}

class NewFormEmail extends EmailState {}

///EMail Events
///
abstract class EmailEvent {}

class PageOnLoadEvent extends EmailEvent {
  PageOnLoadEvent();
}

class OnFormLoadEvent extends EmailEvent {
  OnFormLoadEvent();
}

class OnEmailSaveEvent extends EmailEvent {
  EmailRequest email;

  OnEmailSaveEvent({required this.email});
}

class OnEmailLoadEvent extends EmailEvent {}
