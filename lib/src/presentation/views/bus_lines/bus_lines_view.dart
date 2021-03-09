import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';

import 'bus_line_list_item.dart';
import 'controller/bus_line_view_controller.dart';

class BusLinesView extends StatelessWidget {
  final BusLineViewController viewController = BusLineViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppString.titleBusLinesView,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<BusLine>>(
                future: viewController.getBusLines(),
                builder: (BuildContext context, AsyncSnapshot<List<BusLine>> snapshot) {
                  if (snapshot.hasData) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 3, childAspectRatio: 2.5),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var busLine = snapshot.data[index];
                        return BusLineListItem(busLine: busLine);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
