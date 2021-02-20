import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarbus2021/src/app/app_consts.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/utils/shared_preferences_utils.dart';

import 'appbar_title.dart';

class FavouritesEditBusStopDialog extends StatefulWidget {
  final BusStop busStop;
  final String oldName;

  const FavouritesEditBusStopDialog({Key key, this.busStop, this.oldName}) : super(key: key);

  @override
  _FavouritesEditBusStopDialogState createState() => _FavouritesEditBusStopDialogState();
}

class _FavouritesEditBusStopDialogState extends State<FavouritesEditBusStopDialog> {
  final _busStopNameController = TextEditingController();
  final _inputNode = FocusNode();
  final _isFirstOpen = true;
  var _validated = true;

  void openKeyboard() {
    FocusScope.of(context).requestFocus(_inputNode);
  }

  void closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  String validate(String text) {
    var textCharArray = text.split('');
    for (var a in textCharArray) {
      if (a == '"' || a == ',' || a == '\'') {
        _validated = false;
        return AppString.labelNameRequitments;
      }
    }
    _validated = true;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (_isFirstOpen) {
      openKeyboard();
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            closeKeyboard();
            Navigator.of(context).pop(true);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            AppBarTitle(title: AppString.labelEdit),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!_validated) {
                return;
              }
              if (_busStopNameController.text.isEmpty) {
                _busStopNameController.text = widget.oldName;
              }
              if (await SharedPreferencesUtils.editByIndex(
                  AppConsts.SharedPreferencesFavStop, widget.busStop.id.toString(), _busStopNameController.text, 0)) {
                closeKeyboard();
                Navigator.of(context).pop(true);
              }
            },
            child: Text(AppString.labelSaveUppercase),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.busStop.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            Row(
              children: [
                Text('${AppString.labelDestinations}: '),
                Text(widget.busStop.destinations),
              ],
            ),
            Text('${AppString.labelLocation}: ${widget.busStop.lat}, ${widget.busStop.lng}'),
            Container(
              height: 10.0,
            ),
            Text(
              '${AppString.labelOldName}: ${widget.oldName}',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 65.0,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  maxLength: 20,
                  focusNode: _inputNode,
                  autofocus: true,
                  controller: _busStopNameController,
                  validator: validate,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                  ],
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(),
                    ),
                    labelText: AppString.labelTypeNewName,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
