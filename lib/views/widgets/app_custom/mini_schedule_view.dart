import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/departures_mini_cubit/departures_mini_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/config/app_icons.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';

class MiniScheduleView extends StatefulWidget {
  final BusStop busStop;

  const MiniScheduleView({Key? key, required this.busStop}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MiniScheduleViewState();
}

class _MiniScheduleViewState extends State<MiniScheduleView> {
  @override
  void initState() {
    context
        .read<DeparturesMiniCubit>()
        .initDepartures(busStopId: widget.busStop.id);
    super.initState();
  }

  Widget _buildDepartureCard(
      DeparturesMiniLoaded state, Departure departure, int index) {
    return Card(
      child: InkWell(
        onTap: () {
          context.router.navigate(DepartureDetailsRoute(departure: departure));
        },
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 30,
              color: AppColors.of(context).primaryColor,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppIcons.of(context).busStopIcon,
                    Text(
                      departure.track.route.busLine.name,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    departure.timeInString,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (state.breakpoint != null && state.breakpoint! <= index)
                    Text(
                      'Jutro',
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: AppColors.of(context).primaryColor,
                            fontSize: 11,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      constraints: BoxConstraints(minHeight: 200, maxHeight: 280),
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Positioned(
            top: 0,
            bottom: 7,
            left: 0,
            right: 0,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      widget.busStop.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child:
                          BlocBuilder<DeparturesMiniCubit, DeparturesMiniState>(
                        builder: (context, state) {
                          if (state is DeparturesMiniLoaded) {
                            if (state.departures.isEmpty) {
                              return Center(
                                child: Text(
                                  'Brak nalbliższych odjazdów z tego przystanku',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline3!
                                      .copyWith(
                                        color: Colors.red,
                                      ),
                                ),
                              );
                            }
                            return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3, childAspectRatio: 1.2),
                              physics: NeverScrollableScrollPhysics(),
                              // to disable GridView's scrolling
                              shrinkWrap: true,
                              itemCount: state.departures.length,
                              itemBuilder: (BuildContext context, int index) {
                                return _buildDepartureCard(
                                    state, state.departures[index], index);
                              },
                            );
                          }
                          return CenterLoadSpinner();
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        context.router.navigate(DeparturesRoute(
                          busStopId: widget.busStop.id,
                          busStopName: widget.busStop.name,
                        ));
                      },
                      child: Text('Zobacz rozkład przystanku'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -18,
            left: 0,
            right: 0,
            child: Container(
              child: Icon(
                Icons.arrow_drop_down_sharp,
                color: AppColors.of(context).primaryColor,
                size: 50,
              ),
            ),
          )
        ],
      ),
    );
  }
}
