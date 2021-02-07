import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/utils/favourites_bus_stop_utils.dart';

import 'appbar_title.dart';

class FavouritesEditBusStopDialog extends StatefulWidget {
  final BusStop busStop;
  final String oldName;

  const FavouritesEditBusStopDialog({Key key, this.busStop, this.oldName}) : super(key: key);

  @override
  _FavouritesEditBusStopDialogState createState() => _FavouritesEditBusStopDialogState();
}

class _FavouritesEditBusStopDialogState extends State<FavouritesEditBusStopDialog> {
  var _busStopNameController = TextEditingController();
  var _inputNode = FocusNode();
  var _isFirstOpen = true;
  var _validated = true;

  void openKeyboard() {
    FocusScope.of(context).requestFocus(_inputNode);
  }

  void closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  String validate(String text) {
    var textCharArray = text.split("");
    for (String a in textCharArray) {
      if (a == '\"' || a == ',' || a == '\'') {
        _validated = false;
        return 'Pole nie może zawierać znaków (")(,)(\')';
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
            AppBarTitle(title: 'Edycja'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!_validated) {
                return;
              }
              if (await FavouritesBusStopUtils.editName(widget.busStop.id.toString(), _busStopNameController.text)) {
                closeKeyboard();
                Navigator.of(context).pop(true);
              }
            },
            child: Text('ZAPISZ'),
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
                Text('Kierunki: '),
                Text(widget.busStop.destinations),
              ],
            ),
            Text('Lokalizacja: ${widget.busStop.lat}, ${widget.busStop.lng}'),
            Container(
              height: 10.0,
            ),
            Text(
              'Stara nazwa: ${widget.oldName}',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                height: 65.0,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  maxLength: 20,
                  focusNode: _inputNode,
                  autofocus: true,
                  controller: _busStopNameController,
                  validator: (text) => validate(text),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                  ],
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      borderSide: new BorderSide(),
                    ),
                    labelText: 'Wpisz nową nazwę',
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
