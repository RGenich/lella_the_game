import 'dart:convert';
import 'dart:io';

class Requests {
  static Future<List<Request>> deserialize() async {
    List<Request> _requests = [];
    File file = File("assets/requests.json");
    String content = await file.readAsString();
    final decoded = json.decode(content);
    for (final item in decoded) {
      _requests.add(Request(item["number"] as int, item["header"] as String,
          item["assetName"] as String, item["description"] as String));
    }
    return _requests;
  }
}

class Request {
  final int number;
  final String header;
  final String assetName;
  final String description;

  Request(this.number, this.header, this.assetName, this.description);
}
