part of 'request_bloc.dart';

@immutable
abstract class RequestEvent { }

class InitializingRequestsEvent extends RequestEvent {
  InitializingRequestsEvent();
}


class RequestCellBuiltEvent extends RequestEvent {
  final RequestData request;
  final Offset position;
  RequestCellBuiltEvent({required this.request, required this.position});
}

