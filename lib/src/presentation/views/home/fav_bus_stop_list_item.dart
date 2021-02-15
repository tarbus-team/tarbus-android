import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_consts.dart';
import 'package:tarbus2021/src/model/entity/bus_stop_arguments_holder.dart';
import 'package:tarbus2021/src/model/entity/custop_popup_menu.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/favourites_edit_bus_stop_dialog.dart';
import 'package:tarbus2021/src/presentation/views/schedule/factory_schedule_view.dart';
import 'package:tarbus2021/src/utils/shared_preferences_utils.dart';

class FavBusStopListItem extends StatelessWidget {
  final favBusStop;
  final onUpdate;

  const FavBusStopListItem({Key key, this.favBusStop, this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List choices = [
      CustomPopupMenu(
        title: 'Usuń',
        icon: Icons.delete_outline,
        action: () {
          SharedPreferencesUtils.removeByIndex(AppConsts.SharedPreferencesFavStop, favBusStop.busStop.id.toString(), 0);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Pomyślnie skasowano!'),
            ),
          );
        },
      ),
      CustomPopupMenu(
        title: 'Edytuj',
        icon: Icons.edit,
        action: () async {
          var operationStatus = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavouritesEditBusStopDialog(busStop: favBusStop.busStop, oldName: favBusStop.name),
            ),
          );
          if (operationStatus) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Pomyślnie zedytowano!'),
              ),
            );
          }
        },
      ),
    ];

    return Card(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
      child: ListTile(
        onTap: () async {
          await Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(FactoryScheduleView.route, arguments: BusStopArgumentsHolder(busStop: favBusStop.busStop));
          onUpdate();
        },
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/icons/icon_bus_stop.svg',
              width: 25,
              height: 25,
              color: AppColors.instance(context).iconColor,
            ),
          ],
        ),
        title: Text(favBusStop.name),
        subtitle: Text(favBusStop.busStop.name),
        trailing: PopupMenuButton(
          elevation: 3.2,
          onSelected: (value) {
            value.action();
          },
          itemBuilder: (BuildContext context) {
            return choices.map((choice) {
              return PopupMenuItem(
                height: 20.0,
                value: choice,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    choice.action();
                    onUpdate();
                  },
                  child: Row(
                    children: [
                      Icon(
                        choice.icon,
                        color: AppColors.instance(context).iconColor,
                      ),
                      Container(
                        width: 10,
                      ),
                      Text(choice.title),
                    ],
                  ),
                ),
              );
            }).toList();
          },
          child: Icon(
            Icons.more_vert,
            color: AppColors.instance(context).iconColor,
          ),
        ),
      ),
    );
  }
}
