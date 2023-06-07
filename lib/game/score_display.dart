import 'package:Leela/game/leela.dart';
import 'package:flutter/material.dart';


class ScoreDisplay extends StatefulWidget {
  final game;

  ScoreDisplay(this.game);

  @override
  State<ScoreDisplay> createState() => _ScoreDisplayState(game);
}

class _ScoreDisplayState extends State<ScoreDisplay> {
  var game;
  LeelaGame? game2;
    double x = 0.0;
    @override
  void initState() {
    game2 = game as LeelaGame;
    x = game2!.size.x;
    super.initState();
  }
  _ScoreDisplayState(this.game);

  @override
  Widget build(BuildContext context) {
    ;
    return Column(children: [
      Text(
        'Size X: ${x}',
        style: Theme.of(context).textTheme.displaySmall!,
      ),
     FloatingActionButton(
              onPressed: () {
                print('press');
                setState(() {x = game2!.size.x;});})
    ]);
  }
}
