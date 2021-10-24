import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/available_version_model.dart';

class FirstConfigPageListItem extends StatefulWidget {
  final AvailableVersionModel versionModel;
  final Function(AvailableVersionModel, bool) onSelect;

  const FirstConfigPageListItem(
      {Key? key, required this.versionModel, required this.onSelect})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FirstConfigPageListItem();
}

class _FirstConfigPageListItem extends State<FirstConfigPageListItem> {
  static const double TILE_SIZE = 45;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: (value) {
        widget.onSelect(widget.versionModel, value!);
        setState(() {
          isSelected = !isSelected;
        });
      },
      selectedTileColor: AppColors.of(context).primaryLight,
      activeColor: AppColors.of(context).primaryColor,
      value: isSelected,
      selected: isSelected,
      controlAffinity: ListTileControlAffinity.leading,
      title: Container(
        width: TILE_SIZE,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.network(
              widget.versionModel.avatarSrc!,
              width: TILE_SIZE - 10,
              height: TILE_SIZE - 10,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.versionModel.companyName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.versionModel.subscribeCode,
                  style: Theme.of(context).textTheme.bodyText1!,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
