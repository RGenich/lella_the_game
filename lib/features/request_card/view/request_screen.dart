import 'package:Leela/service/request_loader.dart';
import 'package:flutter/material.dart';

import '../widgets/request_card.dart';

class RequestInfo extends StatelessWidget {
  Request? _request;
  RequestInfo([this._request]);

  @override
  Widget build(BuildContext context) {
    
    return RequestCard(request: _request);
  }
}
