import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../request_card/mini_card.dart';

class PlayerInput extends StatelessWidget {
  const PlayerInput({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();
    var textTheme = Theme.of(context).textTheme;
    return Container(
      child: Row(
        children: [
          Expanded(
              child: TextField(
            decoration: InputDecoration(fillColor: Colors.cyan),
          )),
          ElevatedButton.icon(
            onPressed: () async {
              var request = appState.throwDice();
              showDialog(
                  context: context,
                  builder: (context) {
                    //TODO: ошибка здесь
                    // appState.markOpenTime();
                    return MiniCard(request);
                  });
              // Navigator.of(context).pushNamed("/card", arguments: request);
            },
            label: Text('Go', style: textTheme.bodyLarge),
            icon: Icon(
              Icons.grid_on,
              // size: 50,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
