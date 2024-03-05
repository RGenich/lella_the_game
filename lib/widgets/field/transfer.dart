import 'package:flutter/material.dart';


enum TransferType { ARROW, SNAKE }

class Transfer {
  int startNumCell;
  int endCellNum;
  TransferType type;
  bool isVisible = false;

  Transfer(this.startNumCell, this.endCellNum, this.type,
      {Offset? startPos, Offset? endPos, bool? isVisible});
}