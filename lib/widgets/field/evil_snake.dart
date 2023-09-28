import 'package:Leela/widgets/field/transfer.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../leela_app.dart';

class TransferWidget extends StatefulWidget {
  final Transfer transferData;

  TransferWidget({required Key key, required this.transferData}) : super(key: key);

  @override
  State<TransferWidget> createState() => _TransferWidgetState(transferData);
}

class _TransferWidgetState extends State<TransferWidget> {
  Transfer transfer;

  _TransferWidgetState(this.transfer);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LeelaAppState>();
    var startSnakePos = transfer.startPos;
    var endSnakePos = transfer.endPos;
    var type = transfer.type;
    Size cellSize = state.currentCellSize;
    var angle = 0.0;
    var length = 0.0;
    var top = startSnakePos.dy + cellSize.height / 3;
    var left = startSnakePos.dx + cellSize.width / 2;
    angle = calculateAngle(startSnakePos, endSnakePos, cellSize);
    length = calculateLength(startSnakePos, endSnakePos);
    print('building ${transfer.startNum} + ${transfer.endNum}');
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: angle,
        origin: Offset(0, -20),
        alignment: Alignment.bottomLeft,
        child: Container(
          width: length,
          height: length > 220 ? 50 : 30,
          //TODO вернуть
          // height: cellSize.height / 100 * 60,
          // decoration: BoxDecoration(border: Border.all(color: Colors.tealAccent)),
          child: Image.asset(
            type == TransferType.SNAKE
                ? 'assets/images/snake.png'
                : 'assets/images/narrow.png',
            fit: BoxFit.fill,
            // style: txtStyle.displaySmall,
          ),
          // ),
        ),
      ),
    );
    // : SizedBox.shrink();
  }

  double calculateAngle(
      Offset startSnakePos, Offset endSnakePos, Size cellSize) {
    var x1 = startSnakePos.dx + cellSize.width / 3;
    var y1 = startSnakePos.dy + cellSize.height / 3;
    var x2 = endSnakePos.dx + cellSize.width / 3;
    var y2 = endSnakePos.dy + cellSize.height / 2;
    var at = atan2(y2 - y1, x2 - x1);

    return at;
  }

  double calculateLength(Offset startSnakePos, Offset endSnakePos) {
    var x1 = startSnakePos.dx;
    var y1 = startSnakePos.dy;
    var x2 = endSnakePos.dx;
    var y2 = endSnakePos.dy;
    var vec = Vector2(y2 - y1, x2 - x1);
    return vec.length;
  }
}
