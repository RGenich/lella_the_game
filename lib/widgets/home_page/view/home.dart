import 'package:Leela/widgets/field/field_screen.dart';
import 'package:Leela/widgets/request_list/view/requests_list_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // Widget page = definePage();

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(body: Column(children: [Expanded(child: FieldWidget())]));
    });
  }

  Widget definePage() {
    switch (selectedIndex) {
      case 0:
        return FieldWidget();
      case 1:
        return ListOfRequest();
      // case 1:
      //   return GameWidget(game: game, overlayBuilderMap: <String,
      //       Widget Function(BuildContext, LeelaGame game)>{
      //     'gameOverlay': (context, game) => GameOverlay(game),
      //   });
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }
}
