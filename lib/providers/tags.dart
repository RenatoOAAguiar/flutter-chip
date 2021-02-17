import 'package:flutter/material.dart';
import 'package:tag/models/tag.dart';

class Tags with ChangeNotifier {
  List<Tag> _items = [
    Tag(
      name: "5555555555",
      isDelete: false,
    ),
  ];

  List<Tag> get items {
    return [..._items];
  }

  void addTag(Tag tag) {
    _items.add(tag);
    notifyListeners();
  }

  void removeByName(String name) {
    _items.removeWhere((element) => element.name == name);
    notifyListeners();
  }

  bool filterByName(String name) {
    return (_items.firstWhere((it) => it.name == name, orElse: () => null)) !=
        null;
  }

  void updateWhere(Tag tag) {
    final index = _items.indexWhere(
        (element) => element.name.toLowerCase() == tag.name.toLowerCase());
    _items[index] = tag;
    notifyListeners();
  }

  void setChipsDefault() {
    List<Tag> newList = [];
    _items.forEach((
      element,
    ) {
      element.isDelete = false;
      newList.add(element);
    });
    _items = newList;
    notifyListeners();
  }

  void reOrder(int oldIndex, int newIndex) {
    var _temp = _items[newIndex];
    _items[newIndex] = _items[oldIndex];
    _items[oldIndex] = _temp;
    notifyListeners();
  }
}
