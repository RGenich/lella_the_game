import 'package:Leela/bloc/request_bloc/request_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transfer_widget.dart';

enum TransferType { ARROW, SNAKE }

class Transfer {
  int startNumCell;
  Offset startPos = Offset.zero;
  int endCellNum;
  Offset endPos = Offset.zero;
  GlobalKey? startCellKey;
  GlobalKey? endCellKey;
  TransferType type;
  bool isVisible = false;

  Transfer(this.startNumCell, this.endCellNum, this.type,
      {Offset? startPos, Offset? endPos, bool? isVisible});
}

class Snakes extends StatefulWidget {
  const Snakes({super.key});

  @override
  State<Snakes> createState() => _SnakesState();
}

class _SnakesState extends State<Snakes> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        if (state is AllTransferDefinedEvent) {
          return Stack( children: [
              for (Transfer transfer in state.transfers)
              TransferWidget(key: UniqueKey(), transferData: transfer)
              ]);
        }
        else return CircularProgressIndicator(color: Colors.deepOrange);
      },
    );
  }
}
