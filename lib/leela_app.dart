import 'package:Leela/router/routes.dart';
import 'package:Leela/service/request_loader.dart';
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
  void initState() {
    super.initState();
  }

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
  int count = 0;
  List<RequestModel> _requests = List.empty(growable: true);

  Future<List<RequestModel>> get loadRequests async {
    return loadRequest();
    // return _requests;
  }

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

  Future<List<RequestModel>> loadRequest() async {
    if (_requests.isEmpty) {
      var list = await Requests.deserialize();
      _requests.addAll(list);
      notifyListeners();
      // Requests.deserialize().then((value) {
      //   _requests.addAll(value);
      //   notifyListeners();
      // });
    }
    return _requests;
  }
  int buildNum = 0;
  int getNextCellNumber() {
    return buildNum;
  }
//функция хранит какие отстроены клетки и
// возвращает какую надо построить следующей
}
