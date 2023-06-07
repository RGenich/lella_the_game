import 'package:Leela/features/field/field_screen.dart';
import 'package:Leela/features/request_list/view/requests_list_screen.dart';
import 'package:Leela/game/leela.dart';
import 'package:Leela/leela_app.dart';
import 'package:Leela/service/request_loader.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../game/overlay.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  var game = LeelaGame();

  @override
  Widget build(BuildContext context) {
    Widget page = definePage();

    void _onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: page,
              ),
            ),


            BottomNavigationBar(onTap: _onItemTapped, items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.accessibility_rounded),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_list_numbered),
                label: 'Requests',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ]),
            //////////
            // SafeArea(
            //   child: NavigationRail(
            //     // extended: constraints.maxWidth > 600,
            //     destinations: [
            //       NavigationRailDestination(
            //         icon: Icon(Icons.list),
            //         label: Text('Requests'),
            //       ),
            //       NavigationRailDestination(
            //         icon: Icon(Icons.play_arrow_outlined),
            //         label: Text('Leela'),
            //       ),
            //       NavigationRailDestination(
            //         icon: Icon(Icons.play_arrow_outlined),
            //         label: Text('Field'),
            //       ),
            //     ],
            //     selectedIndex: selectedIndex,
            //     onDestinationSelected: (value) {
            //       setState(() {
            //         selectedIndex = value;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      );
    });
  }


  // BottomNavigationBar(onTap: _onItemTapped, items: [
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.accessibility_rounded),
  //     label: 'Game',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.format_list_numbered),
  //     label: 'Requests',
  //   ),
  //   BottomNavigationBarItem(
  //     icon: Icon(Icons.school),
  //     label: 'School',
  //   ),
  // ]),

  Widget definePage() {
    switch (selectedIndex) {
      case 0:
        return ListOfRequest();
      case 1:
        return FieldWidget();
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
