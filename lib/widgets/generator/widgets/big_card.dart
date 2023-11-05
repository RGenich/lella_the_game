//
// import 'package:english_words/english_words.dart';
// import 'package:flutter/material.dart';
//
// class BigCard extends StatelessWidget {
//   const BigCard({
//     super.key,
//     required this.pairStr,
//   });
//
//   final WordPair pairStr;
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     final stylevariable = theme.textTheme.displayMedium!.copyWith(
//       letterSpacing: 2.0,
//       // color: theme.colorScheme.onPrimary,
//     );
//     return Card(
//       // color: theme.colorScheme.primary,
//       child: Padding(
//         padding: const EdgeInsets.all(100.0),
//         child: Text(
//           pairStr.asSnakeCase,
//           style: stylevariable,
//         ),
//       ),
//     );
//   }
// }