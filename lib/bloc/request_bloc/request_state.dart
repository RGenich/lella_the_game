part of 'request_bloc.dart';

// @immutable
abstract class RequestState extends Equatable{
  const RequestState();
  List<Object?> get props => [];
}

class RequestInitialState extends RequestState { }

class RequestLoadedState extends RequestState {
  final List <RequestData> requests;
  RequestLoadedState({required this.requests});

  @override
  List<Object?> get props => [requests];

}

