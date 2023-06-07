import 'package:Leela/game/score_display.dart';
import 'package:flutter/material.dart';

class GameOverlay extends StatefulWidget {
  GameOverlay (this.game);
  final game;
  @override
  State<GameOverlay> createState() => _GameOverlayState(game);
}

class _GameOverlayState extends State<GameOverlay> {
  var game;

  _GameOverlayState(this.game);

  
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Stack(children: [
          Positioned(
            top: 30,
            left: 30,
            child: ScoreDisplay(game),
          ),
        ]));
  }
}
