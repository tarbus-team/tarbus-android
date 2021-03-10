import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tarbus2021/app/app_consts.dart';
import 'package:tarbus2021/app/app_dimens.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/entity/bus_stop.dart';
import 'package:tarbus2021/utils/shared_preferences_utils.dart';

import 'appbar_title.dart';

class FavouritesBusStopDialog extends StatefulWidget {
  final BusStop busStop;

  const FavouritesBusStopDialog({Key key, this.busStop}) : super(key: key);

  @override
  _FavouritesBusStopDialogState createState() => _FavouritesBusStopDialogState();
}

class _FavouritesBusStopDialogState extends State<FavouritesBusStopDialog> {
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
            Navigator.of(context).pop(false);
          },
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            AppBarTitle(title: AppString.labelAddToFavourites),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (!_validated) {
                return;
              }
              if (_busStopNameController.text.isEmpty) {
                _busStopNameController.text = AppString.labelNewBusStopUppercase;
              }
              if (await SharedPreferencesUtils.add(
                  AppConsts.SharedPreferencesFavStop, '${widget.busStop.id.toString()}, ${_busStopNameController.text}')) {
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
                    LengthLimitingTextInputFormatter(20),
                  ],
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(),
                    ),
                    labelText: AppString.labelActionAddToFav,
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
