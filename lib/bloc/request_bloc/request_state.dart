part of 'request_bloc.dart';

@immutable
class RequestState{
  late final List <RequestData> requests;
  RequestState({this.requests = const []});
}

class RequestInitialState extends RequestState { }

class RequestLoadedState extends RequestState {
  RequestLoadedState({required List <RequestData> requests}) : super(requests: requests);
}
class RequestReloadCellState extends RequestState {
  final int keyNum;
  RequestReloadCellState({required this.keyNum});
}
class RequestPositionDefinedState extends RequestState {
  RequestPositionDefinedState({ required List<RequestData> requests}) : super (requests: requests);
}
class RequestChangedState extends RequestState {
  RequestChangedState({ required List<RequestData> requests}) : super (requests: requests);
}
