import 'package:Leela/widgets/field/play_zone.dart';
import 'package:flutter/material.dart';
import 'dice_widget.dart';

class FieldWidget extends StatefulWidget {
  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget>
    with TickerProviderStateMixin {
  List<GameRow> rows = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 9, child: PlayZone()),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Dice()],
              ),
            )
          ],
        ),
      ),
    );
  }
}
