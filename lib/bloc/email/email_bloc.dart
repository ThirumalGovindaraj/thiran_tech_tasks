import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/github/github_repository.dart';
import 'package:tasks/bloc/github/github_response.dart';

import '../github/error_response.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final GithubRepository _repository = GithubRepository();

  EmailBloc(EmailInitial transactionInitial) : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {
      dynamic response = await _repository.getGithubRepository(url: event.url);
      if (response is GithubResponse) {
        emit(EmailLoaded(response));
      } else {
        emit(EmailError(response));
      }
    });
    on<OnEmailListEvent>((event, emit) async {});
    on<OnEmailLoadEvent>((event, emit) async {
      emit(EmailLoading());
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
  final GithubResponse response;

  const EmailLoaded(this.response);
}

class TextEmailLoaded extends EmailState {
  const TextEmailLoaded();
}

class EmailError extends EmailState {
  final ErrorResponse error;

  const EmailError(this.error);
}

///EMail Events
///
abstract class EmailEvent {}

class PageOnLoadEvent extends EmailEvent {
  String url;

  PageOnLoadEvent(this.url);
}

class OnEmailListEvent extends EmailEvent {
  String emailText;

  OnEmailListEvent({this.emailText = ""});
}

class OnEmailLoadEvent extends EmailEvent {}
