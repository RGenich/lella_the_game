// import 'package:Leela/game/leela.dart';
// import 'package:flame/components.dart';
// import 'package:flutter/material.dart';
// import 'package:flame/parallax.dart';
//
// class Background extends ParallaxComponent<LeelaGame> {
//
//   static var currenetSizeX = 0.0;
//
//   @override
//   Future<void> onLoad() async {
//
//     parallax = await gameRef.loadParallax(
//       [
//         ParallaxImageData('game/background/06_Background_Solid.png'),
//         ParallaxImageData('game/background/05_Background_Small_Stars.png'),
//         ParallaxImageData('game/background/04_Background_Big_Stars.png'),
//         ParallaxImageData('game/background/02_Background_Orbs.png'),
//         ParallaxImageData('game/background/03_Background_Block_Shapes.png'),
//         ParallaxImageData('game/background/01_Background_Squiggles.png'),
//       ],
//       fill: LayerFill.width,
//       repeat: ImageRepeat.repeat,
//       baseVelocity: Vector2(0, -5),
//       velocityMultiplierDelta: Vector2(0, 1.2),
//     );
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     currenetSizeX = gameRef.size.x;
//     print(currenetSizeX);
//   }
// }
