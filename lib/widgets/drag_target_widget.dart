import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tag/widgets/chip_widget.dart';
import 'package:tag/models/tag.dart';
import 'package:tag/providers/tags.dart';

class DragTargetWidget extends StatelessWidget {
  const DragTargetWidget({
    Key key,
    @required this.runSpacing,
    @required this.spacing,
    @required List<Tag> tags2,
  })  : _tags2 = tags2,
        super(key: key);

  final double runSpacing;
  final double spacing;
  final List<Tag> _tags2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: DragTarget<Tag>(
        builder: (context, List<Tag> candidateData, rejectedData) {
          return SingleChildScrollView(
            child: Wrap(
              runSpacing: runSpacing,
              spacing: spacing,
              alignment: WrapAlignment.center,
              children: List.generate(_tags2.length, (index) {
                return ChipWidget(
                  tag: _tags2[index],
                  listType: 1,
                );
              }),
            ),
          );
        },
        onWillAccept: (Tag tag) {
          return true;
        },
        onAccept: (Tag tag) {
          Provider.of<Tags>(context, listen: false).removeByName(tag.name);
        },
      ),
    );
  }
}
