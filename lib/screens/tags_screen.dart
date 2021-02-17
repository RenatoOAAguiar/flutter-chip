import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tag/widgets/chip_widget.dart';
import 'package:tag/models/tag.dart';
import 'package:tag/providers/tags.dart';

class TagsScreen extends StatefulWidget {
  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  final TextEditingController _inputValue = new TextEditingController();
  final double runSpacing = 4;
  final double spacing = 4;
  final int listSize = 15;
  final columns = 4;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey();

  @override
  void dispose() {
    // TODO: implement dispose
    _inputValue.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Tag> _tags = Provider.of<Tags>(context).items;
    final w = (MediaQuery.of(context).size.width - runSpacing * (columns - 1)) /
        columns;

    void _save() {
      // Validate
      if (_inputValue.text.isEmpty) {
        return;
      }

      bool delete = false;
      Tag tag = new Tag(name: _inputValue.text, isDelete: delete);
      var provider = Provider.of<Tags>(context, listen: false);

      // Set chips colors
      provider.setChipsDefault();

      bool t = provider.filterByName(_inputValue.text);
      if (provider.items.length == 0 || !t) {
        provider.addTag(tag);
      } else {
        tag.isDelete = true;
        provider.updateWhere(tag);
      }
      _inputValue.clear();
    }

    return Scaffold(
      appBar: null,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Add new Tag',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Container(
                  width: 100,
                  child: TextField(
                    onSubmitted: (value) {
                      _save();
                    },
                    controller: _inputValue,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.check),
                onPressed: _save,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                height: 15,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 200,
                      child: SingleChildScrollView(
                        child: Wrap(
                          runSpacing: runSpacing,
                          spacing: spacing,
                          alignment: WrapAlignment.center,
                          children: List.generate(_tags.length, (index) {
                            return Draggable(
                              maxSimultaneousDrags: 1,
                              childWhenDragging: Container(),
                              data: _tags[index],
                              feedback: Material(
                                color: Colors.transparent,
                                child: ChipWidget(
                                  tag: _tags[index],
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: ChipWidget(
                                  tag: _tags[index],
                                ),
                              ),
                            );
                          }),
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
