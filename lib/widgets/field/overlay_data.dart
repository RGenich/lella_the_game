import 'package:Leela/leela_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OverlayInfo extends StatefulWidget {
  const OverlayInfo({super.key});
  @override
  State<OverlayInfo> createState() => _OverlayInfoState();
}

class _OverlayInfoState extends State<OverlayInfo> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<LeelaAppState>();
    var droppedFields = appState.openedCells;
    int lastScore = appState.getLastDiceScore;
    return Row(
      children: [
        Text('${droppedFields}'),
        Text(lastScore.toString())],
    );
  }
}
