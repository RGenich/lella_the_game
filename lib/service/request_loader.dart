import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Requests {
  static List<RequestModel> deserialize()  {
    // List<RequestModel> _requests =
    return [
      new RequestModel("he", "please", "work,", 1)
    ];
  }
}
  //   String content = await rootBundle.loadString('assets/requests.json');
  //   final decoded = json.decode(content);
  //   for (final item in decoded) {
  //     _requests.add(RequestModel(
  //         item["header"] as String,
  //         item["asset_name"] as String,
  //         item["description"] as String,
  //         item["num"] as int));
  //   }
  //   return _requests;
  // }
// }

class RequestModel {
  final String header;
  final String asset_name;
  final String description;
  bool isOpen = false;
  final int num;

  RequestModel(this.header, this.asset_name, this.description, this.num);
}
