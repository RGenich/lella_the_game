part of 'request_bloc.dart';

@immutable
abstract class RequestState{

  final List<Transfer> allTransfers =  [
    Transfer(12, 8, TransferType.SNAKE),
    Transfer(16, 4, TransferType.SNAKE),
    Transfer(24, 7, TransferType.SNAKE),
    Transfer(29, 6, TransferType.SNAKE),
    Transfer(44, 9, TransferType.SNAKE),
    Transfer(52, 35, TransferType.SNAKE),
    Transfer(55, 3, TransferType.SNAKE),
    Transfer(61, 13, TransferType.SNAKE),
    Transfer(63, 2, TransferType.SNAKE),
    Transfer(72, 51, TransferType.SNAKE),

    Transfer(10, 23, TransferType.ARROW),
    Transfer(17, 69, TransferType.ARROW),
    Transfer(20, 32, TransferType.ARROW),
    Transfer(22, 60, TransferType.ARROW),
    Transfer(27, 41, TransferType.ARROW),
    Transfer(28, 50, TransferType.ARROW),
    Transfer(37, 66, TransferType.ARROW),
    Transfer(45, 67, TransferType.ARROW),
    Transfer(46, 62, TransferType.ARROW),
    Transfer(54, 68, TransferType.ARROW),
  ];

  RequestState();
}

class RequestInitialState extends RequestState { }

class RequestLoadedState extends RequestState {
  final List <RequestData> requests;
  RequestLoadedState(this.requests);
}


class AllTransferDefinedEvent extends RequestState {
  AllTransferDefinedEvent();
}