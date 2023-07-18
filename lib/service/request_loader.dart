import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/src/widgets/framework.dart';

class RequestData {
  GlobalKey? _cellKey;
  final int num;
  final String header;
  final String assetName;
  final String description;
  // final int? _destination;

  GlobalKey? get cellKey => _cellKey;

  bool isOpen = false;

  set cellKey(GlobalKey? value) {
    _cellKey = value;
  }

  RequestData(this.header, this.assetName, this.description, this.num);

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
            item['num'] as int
            // item['destination_num'] as int,
          ));
        }
      } catch (e) {
        print('Проблема при десериализации запросов');
      }
    }
    return _requests;
  }

}
