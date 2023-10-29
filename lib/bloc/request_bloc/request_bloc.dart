import 'dart:async';
import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../model/request_data.dart';
import '../../widgets/field/transfer.dart';

part 'request_event.dart';

part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final Repository repository;
  List<RequestData> requests = [];

  RequestBloc(this.repository) : super(RequestInitialState()) {
    on<InitializingRequestsEvent>(_loadRequests);
    on<RequestCellBuiltEvent>(_definePositions);
  }

  _loadRequests(event, emit) async {
    await Future<void>.delayed(Duration(seconds: 1));
    requests = repository.requests;
    emit(RequestLoadedState(requests: requests, isPositionDefined: false));
  }

  void _definePositions(
      RequestCellBuiltEvent event, Emitter<RequestState> emit) {
    var position = event.position;
    var req = event.request;
    req.position = position;
    if (_isPositionDefined()) {
      emit(RequestLoadedState(requests: requests, isPositionDefined: true));
    }
    ;
  }

  bool _isPositionDefined() {
    return !requests.any((req) => req.position == Offset.zero && req.cellKey != null);
  }
}
