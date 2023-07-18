import 'package:Leela/widgets/field/transfer.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../leela_app.dart';

class TransferWidget extends StatefulWidget {
  final transferData;

  TransferWidget(this.transferData);

  @override
  State<TransferWidget> createState() => _TransferWidgetState(transferData);
}

class _TransferWidgetState extends State<TransferWidget> {
  Transfer transfer;

  _TransferWidgetState(this.transfer);

  @override
  Widget build(BuildContext context) {
    var state = context.watch<LeelaAppState>();
    // var pair = state.snakes[SnakeType.evil];
    Offset? startSnakePos = transfer.startPos;
    Offset? endSnakePos = transfer.endPos;
    var type = transfer.type;
    Size cellSize = state.currentCellSize;
    var angle = 0.0;
    var length = 0.0;
    if (startSnakePos != null && endSnakePos != null) {
      angle = calculateAngle(startSnakePos, endSnakePos, cellSize);
      length = calculateLength(startSnakePos, endSnakePos);
    }
    return startSnakePos != null
        ? Positioned(
            top: startSnakePos.dy + cellSize.height / 3,
            left: startSnakePos.dx + cellSize.width / 2,
            child: Transform.rotate(
              angle: angle,
              origin: Offset(0, -20),
              alignment: Alignment.bottomLeft,
              child: Container(
                width: length,
                height: length > 220 ? 50 : 30,
                //TODO вернуть
                // height: cellSize.height / 100 * 60,
                // decoration:
                //     BoxDecoration(border: Border.all(color: Colors.tealAccent)),
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
          )
        : SizedBox.shrink();
  }

  double calculateAngle(
      Offset startSnakePos, Offset endSnakePos, Size cellSize) {
    var x1 = startSnakePos.dx + cellSize.width / 3;
    var y1 = startSnakePos.dy + cellSize.height / 3;
    var x2 = endSnakePos.dx + cellSize.width / 3;
    var y2 = endSnakePos.dy + cellSize.height / 2;
    var at = atan2(y2 - y1, x2 - x1);

    // var xVector = Vector2(startSnakePos.dx  +1 - startSnakePos.dx, endSnakePos.dy - startSnakePos.dy);
    // var yVector = Vector2(endSnakePos.dx - startSnakePos.dx, endSnakePos.dy - startSnakePos.dy);
    // var angleTo = xVector.angleTo(yVector);
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
