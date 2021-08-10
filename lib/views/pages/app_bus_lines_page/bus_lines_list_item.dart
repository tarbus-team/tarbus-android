import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/model/schedule/company.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

class BusLinesListItem extends StatelessWidget {
  final Company company;
  final List<BusLine> busLines;

  const BusLinesListItem(
      {Key? key, required this.company, required this.busLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 35,
              child: Center(
                child: Image.network(
                  "https://dev-api.tarbus.pl/static/company/${company.id}/logo.png",
                  height: 30,
                  errorBuilder: (context, child, trace) {
                    return Text('Error');
                  },
                ),
              ),
            ),
            dense: true,
            title: Text(
              company.name,
              style: Theme.of(context)
                  .textTheme
                  .headline3!
                  .copyWith(fontSize: 16, color: Colors.black),
            ),
            subtitle: Text(
              "Jodłówka-Wałki, Śmigno, Pleśna, Kosz...",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            trailing: Icon(
              Icons.info_outline,
              color: AppColors.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              children: busLines
                  .map(
                    (busLine) => InkWell(
                      onTap: () {
                        context.router.push(LineDetailsRoute(
                            busLineId: busLine.id, busLineName: busLine.name));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: AppColors.of(context).primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/icon_bus.svg',
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            SizedBox(
                              width: 50,
                              child: Center(
                                child: Text(
                                  busLine.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                          fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
