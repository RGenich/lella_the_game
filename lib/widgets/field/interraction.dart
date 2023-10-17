//
// import 'package:Leela/leela_app.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// class PlayerInput extends StatelessWidget {
//   const PlayerInput({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<LeelaAppState>();
//     var textTheme = Theme.of(context).textTheme;
//
//     return Container(
//       child: Row(
//         children: [
//           Expanded(
//               child: TextField(
//             decoration: InputDecoration(fillColor: Colors.cyan),
//           )),
//           ElevatedButton.icon(
//             onPressed: () async {
//               appState.throwRandom();
//               appState.checkMovies();
//               showDialog<void>(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return IgnorePointer(
//                         child: Container(
//                       // color: Colors.black,
//                       width: double.infinity,
//                       // height: nonExpanded,
//                       child: Lottie.asset('assets/lotties/dice.json',
//                           repeat: false, alignment: Alignment.center),
//                     ));
//                   }).then((value) {
//                 appState.defineCellSize();
//                 appState.defineMarkerPosition();
//                 // appState.checkUnvisitedMarkerPositions();
//                 // appState.notifyListeners();
//               });
//               // Navigator.of(context).pushNamed("/card", arguments: request);
//             },
//             label: Text('Go', style: textTheme.bodyLarge),
//             icon: Icon(
//               Icons.grid_on,
//               // size: 50,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
