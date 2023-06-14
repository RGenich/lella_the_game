import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Requests {
  static List<RequestData> _requests = [];

  static Future<List<RequestData>> getRequests() async {
    if (_requests.isEmpty) {
      String content = await rootBundle.loadString('assets/requests.json');
      final decoded = json.decode(content);
      for (final item in decoded) {
        _requests.add(RequestData(
            item["header"] as String,
            item["asset_name"] as String,
            item["description"] as String,
            item["num"] as int));
      }
    }
    return _requests;
  }
}
// }
// }

class RequestData {
  final String header;
  final String asset_name;
  final String description;
  bool isOpen = false;
  final int num;

  RequestData(this.header, this.asset_name, this.description, this.num);
}
