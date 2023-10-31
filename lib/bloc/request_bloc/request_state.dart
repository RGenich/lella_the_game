part of 'request_bloc.dart';

@immutable
class RequestState{
  late final List <RequestData> requests;
  RequestState({this.requests = const []});
}

class RequestInitialState extends RequestState { }

class RequestLoadedState extends RequestState {
  // final List <RequestData> requests;
  // final bool isPositionDefined;
  // RequestLoadedState({required this.requests, required this.isPositionDefined});
  RequestLoadedState({required List <RequestData> requests}) : super(requests: requests);
}
class RequestPositionDefinedState extends RequestState {

  RequestPositionDefinedState({ required List<RequestData> requests}) : super (requests: requests);
}
