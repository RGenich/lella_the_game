part of 'request_bloc.dart';

@immutable
abstract class RequestState{
  RequestState();

}

class RequestInitialState extends RequestState { }

class RequestLoadedState extends RequestState {
  final List <RequestData> requests;
  RequestLoadedState(this.requests);
}


class AllTransferDefinedEvent extends RequestState {
  final List<Transfer> transfers;
  AllTransferDefinedEvent(this.transfers);
}