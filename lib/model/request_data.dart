import 'package:flutter/material.dart';

class RequestData {
  RequestData(this.header, this.assetName, this.description, this.num);

  GlobalKey? _cellKey;
  final int num;
  final String header;
  final String assetName;
  final String description;

  Offset position = Offset.zero;
  Size size = Size.zero;

  GlobalKey? get cellKey => _cellKey;

  set cellKey(GlobalKey? value) {
    _cellKey = value;
  }

  bool isOpen = false;
}
