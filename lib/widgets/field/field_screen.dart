import 'package:Leela/widgets/field/play_zone.dart';
import 'package:Leela/widgets/field/interraction.dart';
import 'package:flutter/material.dart';

class FieldWidget extends StatefulWidget {
  @override
  State<FieldWidget> createState() => _FieldWidgetState();
}

class _FieldWidgetState extends State<FieldWidget> {
  List<GameRow> rows = [];

  @override
  Widget build(BuildContext context) {
    context.widget.key;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // OverlayInfo(),
            PlayZone(),
            PlayerInput()
          ],
          // mainAxisAlignment: MainAxisAlignment.end,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/god.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
