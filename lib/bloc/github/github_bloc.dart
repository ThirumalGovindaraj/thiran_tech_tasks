import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/bloc/github/github_repository.dart';
import 'package:tasks/bloc/github/github_response.dart';

import '../github/error_response.dart';

class GithubBloc extends Bloc<GithubEvent, GithubState> {
  final GithubRepository _repository = GithubRepository();
  GithubResponse githubResponse = GithubResponse();

  GithubBloc(GithubInitial transactionInitial) : super(transactionInitial) {
    on<PageOnLoadEvent>((event, emit) async {
      dynamic response = await _repository.getGithubRepository(url: event.url);
      if (response is GithubResponse) {
        githubResponse = response;
        emit(GithubLoaded(githubResponse));
      } else {
        emit(GithubError(response));
      }
    });
    on<OnGithubListEvent>((event, emit) async {});
    on<OnGithubLoadEvent>((event, emit) async {
      emit(GithubLoading());
    });
  }
}

/// Github States

abstract class GithubState extends Equatable {
  const GithubState();

  @override
  List<Object?> get props => [];
}

class GithubInitial extends GithubState {}

class GithubLoading extends GithubState {}

class GithubLoaded extends GithubState {
  final GithubResponse response;

  const GithubLoaded(this.response);
}

class TextGithubLoaded extends GithubState {
  const TextGithubLoaded();
}

class GithubError extends GithubState {
  final ErrorResponse error;

  const GithubError(this.error);
}

///Github Events
///
abstract class GithubEvent {}

class PageOnLoadEvent extends GithubEvent {
  String url;

  PageOnLoadEvent(this.url);
}

class OnGithubListEvent extends GithubEvent {
  String GithubText;

  OnGithubListEvent({this.GithubText = ""});
}

class OnGithubLoadEvent extends GithubEvent {}
