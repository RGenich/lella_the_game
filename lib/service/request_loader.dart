import 'dart:convert';
import 'package:Leela/widgets/field/snakes.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/src/widgets/framework.dart';

class RequestData {
  GlobalKey? _cellKey;
  final int num;
  final String header;
  final String asset_name;
  final String description;
  final int _endpoint;

  GlobalKey? get cellKey => _cellKey;
  SnakeType _snake;

  SnakeType get snake => _snake;

  int get endPoint => _endpoint;

  set snake(SnakeType value) => _snake = value;

  bool isOpen = false;

  set cellKey(GlobalKey? value) {
    _cellKey = value;
  }

  RequestData(header, asset_name, description, num, snake)
      : header = header,
        asset_name = asset_name,
        description = description,
        num = num,
        _snake = snake,
        _endpoint = snake.endpoint;
}

class RequestsLoader {
  static List<RequestData> _requests = [];

  static Future<List<RequestData>> getRequests() async {
    if (_requests.isEmpty) {
      try {
        String content = await rootBundle.loadString('assets/requests.json');
        final decoded = json.decode(content);
        for (final item in decoded) {
          _requests.add(RequestData(
              item['header'] as String,
              item['asset_name'] as String,
              item['description'] as String,
              item['num'] as int,
              SnakeType.values.byName(
                item['snake'] != null ? item['snake'] : "good",
              )));
        }
      } catch (e) {
        print('Проблема при десериализации запросов');
      }
    }
    return _requests;
  }

  static RequestData? getRequestsWithEvil() {
    for (var req in _requests) {
      if (req._snake == SnakeType.evil) return req;
    }
    return null;
  }
}
