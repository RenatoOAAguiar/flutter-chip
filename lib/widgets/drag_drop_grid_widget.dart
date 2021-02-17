import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tag/widgets/chip_widget.dart';
import 'package:tag/models/tag.dart';
import 'package:tag/providers/tags.dart';

class DragDropGridWidget extends StatelessWidget {
  const DragDropGridWidget({
    Key key,
    @required List<Tag> tags,
  })  : _tags = tags,
        super(key: key);

  final List<Tag> _tags;

  @override
  Widget build(BuildContext context) {
    return DragAndDropGridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 1,
      ),
      padding: EdgeInsets.all(20),
      itemBuilder: (context, index) => ChipWidget(
        tag: _tags[index],
      ),
      itemCount: _tags.length,
      onWillAccept: (oldIndex, newIndex) {
        return true;
      },
      onReorder: (oldIndex, newIndex) {
        Provider.of<Tags>(context).reOrder(oldIndex, newIndex);
      },
    );
  }
}
