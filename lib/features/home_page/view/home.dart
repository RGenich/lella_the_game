//what was home page in video?
import 'package:Leela/features/generator/view/generator_screen.dart';
import 'package:Leela/features/request_card/widgets/request_card.dart';
import 'package:Leela/features/request_list/view/requests_list_screen.dart';
import 'package:Leela/game/leela.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page = definePage(selectedIndex);

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constraints.maxWidth > 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Requests'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.abc),
                    label: Text('Card'),
                  ),    NavigationRailDestination(
                    icon: Icon(Icons.play_arrow),
                    label: Text('Leela'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget definePage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return GeneratorPage();
      case 1:
        return ListOfRequest();
      case 2:
        return RequestCard();
      case 3:
        return GameWidget(game: LeelaGame());
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
  }
}
