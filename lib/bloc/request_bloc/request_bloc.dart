import 'dart:async';
import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
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
    emit(RequestLoadedState(requests: requests));
  }

  void _definePositions(
      RequestCellBuiltEvent event, Emitter<RequestState> emit) {
    var position = event.position;
    var num = event.request.num;
    //начало поиска позиций трансферов
    var foundTransfer = repository.transfers
        .firstWhereOrNull((transfer) => transfer.startNumCell == num);

    if (foundTransfer != null) {
      foundTransfer.startPos = position;
    }

    foundTransfer = repository.transfers
        .firstWhereOrNull((transfer) => transfer.endCellNum == num);
    if (foundTransfer != null) {
      foundTransfer.endPos = position;
    }
    if (_isAllTransfersDefined())
      emit(RequestLoadedState(requests: requests, isPositionDefined: true));
  }

  bool _isAllTransfersDefined() {
    return !repository.transfers.any((element) =>
        element.startPos == Offset.zero || element.endPos == Offset.zero);
  }
}
