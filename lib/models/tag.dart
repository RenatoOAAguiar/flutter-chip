import 'package:flutter/material.dart';

class Tag with ChangeNotifier {
  final String name;
  bool isDelete = false;

  Tag({
    this.name,
    this.isDelete,
  });
}
