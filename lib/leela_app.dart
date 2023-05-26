import 'package:Leela/router/routes.dart';
import 'package:Leela/theme/theme.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LeelaApp extends StatefulWidget {
  const LeelaApp({super.key});

  @override
  State<LeelaApp> createState() => _LeelaAppState();
}

class _LeelaAppState extends State<LeelaApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LeelaAppState(),
      child: MaterialApp(
        title: 'Leela',
        theme: theme,
        routes: routes,
      ),
    );
  }
}


class LeelaAppState extends ChangeNotifier {
  var current = WordPair.random();
  var favArray = <WordPair>[];

  void getNextWords() {
    current = WordPair.random();
    notifyListeners();
  }

  void addToFavorite(WordPair favPair) {
    if (favArray.contains(favPair)) {
      favArray.remove(favPair);
    } else {
      favArray.add(favPair);
    }
    notifyListeners();
  }
}

