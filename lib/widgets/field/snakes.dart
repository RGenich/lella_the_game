import 'package:flutter/material.dart';

import 'evil_snake.dart';

enum SnakeType {
  evil(endpoint: 20),
  good(endpoint: 0);

  final int endpoint;

  const SnakeType({
    required this.endpoint});
}

class Snakes extends StatefulWidget {
  const Snakes({super.key});

  @override
  State<Snakes> createState() => _SnakesState();
}

class _SnakesState extends State<Snakes> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [EvilSnake()]);
  }
}
