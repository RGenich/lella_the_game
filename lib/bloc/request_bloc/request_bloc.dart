import 'dart:async';
import 'dart:ui';

import 'package:Leela/repository/repository.dart';
import 'package:Leela/service/request_keeper.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart';
import '../../model/request_data.dart';
import '../../widgets/field/transfer.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {
  final Repository r;
  List<RequestData> requests = [];

  RequestBloc(this.r) : super(RequestInitialState()) {
    on<InitializingRequestsEvent>(_loadRequests);
    on<RequestCellBuiltEvent>(_defineTransferPositions);
  }

  _loadRequests(event, emit) async {
    await Future<void>.delayed(Duration(seconds: 5));
    requests = r.requests;
    emit(RequestLoadedState(requests));
  }

  void _defineTransferPositions(RequestCellBuiltEvent event, Emitter<RequestState> emit) {
    var position = event.position;
    var num = event.request.num;
    //начало поиска позиций трансферов
    var foundTransfer = r.transfers
        .firstWhereOrNull((transfer) => transfer.startNum == num);

    if (foundTransfer != null) {
      foundTransfer.startPos = position;
    }

    foundTransfer = r.transfers
        .firstWhereOrNull((transfer) => transfer.endNum == num);
    if (foundTransfer != null) {
      foundTransfer.endPos = position;
    }
    //////////////конец поиска трансферов
    // if (_isAllTransfersDefined()) {
    //
    //   //TODO: отдельные для трансферов?
    //   emit(AllTransferDefinedEvent(r.transfers));
    // }
  }

  bool _isAllTransfersDefined() {
    return !r.transfers.any((element) =>
    element.startPos == Offset.zero || element.endPos == Offset.zero);
  }
}