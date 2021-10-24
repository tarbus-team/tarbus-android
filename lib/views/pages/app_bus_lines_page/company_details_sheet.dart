import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/config/app_config.dart';
import 'package:tarbus_app/data/model/schedule/company.dart';

class CompanyDetailsSheet extends StatelessWidget {
  final Company company;

  CompanyDetailsSheet({required this.company});

  final Map<String, String> daysTranslations = {
    'mon': 'Poniedziałek',
    'tue': 'Wtorek',
    'wed': 'Środa',
    'thu': 'Czwartek',
    'fri': 'Piątek',
    'sat': 'Sobota',
    'sun': 'Niedziela',
  };

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> businessCard = company.businessCard;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).backgroundDark,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Column(
                  children: [
                    Image.memory(
                      base64Decode(company.avatar),
                      height: 100,
                      color: context.read<GetAppConfigUseCaseImpl>().isDarkTheme
                          ? Colors.white
                          : null,
                      errorBuilder: (context, child, trace) {
                        return Text('Error');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      company.name,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 23,
                            color: AppColors.of(context).headlineColor,
                          ),
                    ),
                  ],
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.language),
                  label: Text('${company.website}'),
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.mail_outline),
                  label: Text('${company.email}'),
                ),
                TextButton.icon(
                  style: ButtonStyle(
                    visualDensity: VisualDensity(vertical: 0),
                    padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.phone),
                  label: Text('${company.phone}'),
                ),
                SizedBox(
                  height: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Siedziba',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.of(context).headlineColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ...businessCard['office_location']
                        .map((e) => Text(
                              '$e',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ))
                        .toList(),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Godziny otwarcia',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).headlineColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...businessCard['office_hours']
                          .keys
                          .map(
                            (e) => Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${daysTranslations[e]}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      '${businessCard['office_hours'][e]}',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  width: double.infinity,
                  height: 2,
                  color: AppColors.of(context).breakpoint,
                ),
                Text(
                  'Bilety',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).headlineColor,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 25,
                  child: Row(
                    children: [
                      Expanded(flex: 3, child: SizedBox()),
                      ...businessCard['tickets']['types']
                          .map(
                            (e) => Expanded(
                              flex: 2,
                              child: Text(
                                '$e',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  height: 1,
                  color: AppColors.of(context).breakpoint,
                ),
                ...businessCard['tickets']['options'].map(
                  (e) {
                    return SizedBox(
                      height: 25,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              '${e['label']}',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          ...e['prices'].map(
                            (price) => Expanded(
                              flex: 2,
                              child: Text(
                                '$price',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
