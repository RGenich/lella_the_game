part of 'request_bloc.dart';

@immutable
abstract class RequestState{
  RequestState();
}

class RequestInitialState extends RequestState { }

class RequestLoadedState extends RequestState {
  final List <RequestData> requests;
  final bool isPositionDefined;
  RequestLoadedState({required this.requests, this.isPositionDefined = false});
}


class AllTransferDefinedEvent extends RequestState {
  final List<Transfer> transfers;
  AllTransferDefinedEvent(this.transfers);
}