import 'package:Leela/game/background.dart';
import 'package:flame/game.dart';

class LeelaGame extends FlameGame {
  
  @override
  Future<void> onLoad() async {
    await add(Background());
  }
}
