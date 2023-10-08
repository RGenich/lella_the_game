
import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'transfer_widget.dart';


enum TransferType {
  ARROW, SNAKE
}
class Transfer {
  int startNum;
  Offset startPos = Offset.zero;
  int endNum;
  Offset endPos = Offset.zero;
  GlobalKey? startCellKey;
  GlobalKey? endCellKey;
  TransferType type;
  bool isVisible = false;

  Transfer(this.startNum, this.endNum, this.type, {Offset? startPos, Offset? endPos, bool? isVisible});

}

class Snakes extends StatefulWidget {
  const Snakes({super.key});

  @override
  State<Snakes> createState() => _SnakesState();
}

class _SnakesState extends State<Snakes> {
  @override
  Widget build(BuildContext context) {
    List<Transfer> allTransfers = context.watch<LeelaAppState>().allTransfers;
    return Stack(children: [
      for (Transfer transfer in allTransfers)
        if (transfer.startPos != Offset.zero && transfer.isVisible)
          TransferWidget(key: UniqueKey(), transferData: transfer)
    ]);
  }
}
