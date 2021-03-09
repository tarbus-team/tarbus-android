import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/multi_select_chip.dart';

class FilterDepartureDialog extends StatelessWidget {
  final List<String> allBusLines;
  final String filter;

  const FilterDepartureDialog({Key key, this.allBusLines, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedChips = <String>[];
    var filterList = filter.split(',');

    return AlertDialog(
      title: Text(AppString.labelSelect),
      content: MultiSelectChip(
        allBusLines,
        selectedChoices: filterList,
        onSelectionChanged: (selectedList) {
          selectedChips = selectedList;
        },
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            selectedChips = selectedChips.where((chip) => chip != '').toList();
            Navigator.of(context).pop(selectedChips.join(','));
          },
          child: Text(AppString.labelFilter),
        ),
      ],
    );
  }
}
