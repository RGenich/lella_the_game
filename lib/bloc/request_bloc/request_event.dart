part of 'request_bloc.dart';

@immutable
abstract class RequestEvent { }

class InitializingRequestsEvent extends RequestEvent {
  InitializingRequestsEvent();
}

class RequestCellBuiltEvent extends RequestEvent {
  RequestCellBuiltEvent();
}

class RebuildCellsEvent extends RequestEvent{
}

class RebuildOneCellEvent extends RequestEvent{
}
