import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'evil_snake.dart';

enum TransferType { ARROW, SNAKE }

class Transfer {
  int startNum;
  Offset startPos = Offset.zero;
  int endNum;
  Offset endPos = Offset.zero;
  TransferType type;
  bool isVisible = false;

  Transfer(this.startNum, this.endNum, this.type,
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
    var allSnakes = context.watch<LeelaAppState>().allTransfers;
    return Stack(
      children: buildTransfers(allSnakes),
    );
  }

  List<TransferWidget> buildTransfers(List<Transfer> transfersData) {
    List<TransferWidget> transferWidgets = [];
    for (Transfer transferData in transfersData) {
      if (transferData.isVisible)
        transferWidgets.add(new TransferWidget(key: UniqueKey(), transferData: transferData,));
    }
    return transferWidgets;
  }
}
