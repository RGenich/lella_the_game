
import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'evil_snake.dart';

enum TransferType {
  ARROW, SNAKE
}
class Transfer {
  int startNum;
  Offset? startPos;
  int endNum;
  Offset? endPos;
  GlobalKey? startCellKey;
  GlobalKey? endCellKey;
  TransferType type;
  bool isVisible = false;

  Transfer(this.startNum, this.endNum, this.type, {Offset? startPos, Offset? endPos, bool? isVisible});

  void addStartCellKeys(GlobalKey startCell) {
    this.startCellKey = startCell;
    var renderBox = this.startCellKey?.currentContext?.findRenderObject() as RenderBox;
    this.startPos = renderBox.localToGlobal(Offset.zero);
  }

  void addEndCellKeyAfterBuild(GlobalKey endCellKey) {
    this.endCellKey = endCellKey;
    var renderBox = this.endCellKey?.currentContext?.findRenderObject() as RenderBox;
    this.endPos = renderBox.localToGlobal(Offset.zero);
    }
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
    return Stack(children: [
      for (var snake in allSnakes)
        if (snake.startPos!=null && snake.endPos!=null && snake.isVisible) TransferWidget(snake)
    ]);
  }
}
