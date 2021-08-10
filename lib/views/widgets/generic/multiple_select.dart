import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef MultiSelectItemBuilder<T> = Widget Function(
    BuildContext context, T item);

typedef MultiSelectDropdownBuilder<T> = Widget Function(
    BuildContext context, List<T> item);

typedef OnMultiSelectChange<T> = void Function(List<T> items);
typedef MultiSelectComparator<T> = bool Function(T a, T b);

class MultipleSelect<T> extends StatefulWidget {
  final List<T> items;

  final List<T> selectedItems;
  final MultiSelectItemBuilder<T> popupItemBuilder;
  final MultiSelectDropdownBuilder<T> dropdownBuilder;
  final OnMultiSelectChange<T> onChanged;
  final MultiSelectComparator<T> comparator;
  final String? hint;

  const MultipleSelect({
    Key? key,
    required this.items,
    required this.popupItemBuilder,
    required this.dropdownBuilder,
    required this.comparator,
    this.hint,
    required this.selectedItems,
    required this.onChanged,
    // required this.selectedItems,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultipleSelect<T>();
}

class _MultipleSelect<T> extends State<MultipleSelect<T>> {
  List<T> selectedItems = List.empty(growable: true);

  AlertDialog _buildDialog() {
    return AlertDialog(
      title: widget.hint != null ? Text(widget.hint!) : null,
      titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      contentPadding: EdgeInsets.all(0),
      content: MultipleSelectDialogContent(
          items: widget.items,
          comparator: widget.comparator,
          popupItemBuilder: widget.popupItemBuilder,
          selectedItems: widget.selectedItems,
          onChange: (items) {
            setState(() {
              selectedItems = items as List<T>;
              widget.onChanged(selectedItems);
            });
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(context: context, builder: (_) => _buildDialog());
      },
      child: widget.dropdownBuilder(context, selectedItems.toList()),
    );
  }
}

class MultipleSelectDialogContent<T> extends StatefulWidget {
  final List<T> items;
  final MultiSelectItemBuilder<T> popupItemBuilder;
  final OnMultiSelectChange<T> onChange;
  final List<T> selectedItems;
  final MultiSelectComparator<T> comparator;

  const MultipleSelectDialogContent(
      {Key? key,
      required this.items,
      required this.popupItemBuilder,
      required this.comparator,
      required this.onChange,
      required this.selectedItems})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultipleSelectDialogContent<T>();
}

class _MultipleSelectDialogContent<T>
    extends State<MultipleSelectDialogContent<T>> {
  Map<int, T> selectedItems = Map<int, T>();
  Map<int, T> availableItems = Map<int, T>();

  @override
  void initState() {
    int index = 0;
    widget.items.forEach((element) {
      availableItems[index] = element;
      if (widget.selectedItems
              .where((item) => widget.comparator(element, item))
              .length !=
          0) {
        selectedItems[index] = element;
      }
      index += 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Scrollbar(
              child: ListView(
                children: _getList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onChange(widget.selectedItems);
                      context.router.pop();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      elevation: MaterialStateProperty.all(3),
                    ),
                    child: Text(
                      'Anuluj',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5, 5, 20, 5),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onChange(selectedItems.values.toList());
                      context.router.pop();
                    },
                    child: Text('Zapisz'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _getList() {
    List<Widget> widgetList = List.empty(growable: true);
    availableItems.forEach((key, item) {
      widgetList.add(CheckboxListTile(
        dense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        value: selectedItems.containsKey(key),
        selected: selectedItems.containsKey(key),
        title: widget.popupItemBuilder(context, item),
        onChanged: (value) {
          setState(() {
            if (selectedItems.containsKey(key)) {
              selectedItems.remove(key);
            } else {
              selectedItems[key] = item;
            }
            // widget.onChange(selectedItems.values.toList());
          });
        },
      ));
    });
    return widgetList;
  }
}
