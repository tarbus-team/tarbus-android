import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/multi_select_chip.dart';

class FilterDepartureDialog extends StatelessWidget {
  final List<String> allBusLines;
  final String filter;

  const FilterDepartureDialog({Key key, this.allBusLines, this.filter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> selectedChips = <String>[];
    List<String> filterList = filter.split(',');

    return AlertDialog(
      title: Text('Wybierz'),
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
            Navigator.of(context).pop(selectedChips.join(','));
          },
          child: Text('Filtruj'),
        ),
      ],
    );
  }
}
