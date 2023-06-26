import 'package:Leela/service/request_loader.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../leela_app.dart';

class EvilSnake extends StatefulWidget {
  const EvilSnake({super.key});

  @override
  State<EvilSnake> createState() => _EvilSnakeState();
}

class _EvilSnakeState extends State<EvilSnake> {
  // var position = null;

  @override
  Widget build(BuildContext context) {
    var txtStyle = Theme.of(context).textTheme;
    var state = context.watch<LeelaAppState>();
    var snakePos = state.startSnakePos;
    var directPos = state.endSnakePos;
    return snakePos == Offset.zero
        ? SizedBox.shrink()
        : Positioned(
            top: snakePos.dy,
            left: snakePos.dx,
            child: Transform.rotate(
              origin: Offset.zero,
              angle: radians(45.0),
              // angle: radians(0.0),
              alignment: Alignment.bottomLeft,
              // angle: 0.0,
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.tealAccent)),
                child: Text(
                  '>> A R R O W >',
                  style: txtStyle.displaySmall,
                ),
              ),
            ),
          );
    ;
  }
}
