import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tag/models/tag.dart';
import 'package:tag/providers/tags.dart';

class ChipWidget extends StatelessWidget {
  final Tag tag;
  final int listType;

  const ChipWidget({this.tag, this.listType});

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: !this.tag.isDelete ? Colors.blue : Colors.red[500],
      label: Text(
        this.tag.name,
      ),
      deleteIcon: Icon(
        Icons.close,
        color: Colors.white,
      ),
      onDeleted: () {
        Provider.of<Tags>(context, listen: false).removeByName(this.tag.name);
      },
    );
  }
}
