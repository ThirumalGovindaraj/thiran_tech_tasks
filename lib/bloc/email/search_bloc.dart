import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc(EmailInitial transactionInitial) : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {});
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
  const EmailLoaded();
}

class TextEmailLoaded extends EmailState {
  const TextEmailLoaded();
}

class EmailError extends EmailState {
  const EmailError();
}

///EMail Events
///
abstract class EmailEvent {}

class PageOnLoadEvent extends EmailEvent {}

class OnEmailListEvent extends EmailEvent {
  String emailText;

  OnEmailListEvent({this.emailText = ""});
}

class OnEmailLoadEvent extends EmailEvent {}
