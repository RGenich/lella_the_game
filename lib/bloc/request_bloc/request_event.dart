part of 'request_bloc.dart';

@immutable
abstract class RequestEvent extends Equatable{ }

class InitializingRequestsEvent extends RequestEvent {

  List<RequestEvent> requests = [];

  InitializingRequestsEvent();

  @override
  List<Object?> get props => requests;
}
