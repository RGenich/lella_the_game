part of 'request_bloc.dart';

@immutable
abstract class RequestEvent { }

class InitializingRequestsEvent extends RequestEvent {

  InitializingRequestsEvent();
}
