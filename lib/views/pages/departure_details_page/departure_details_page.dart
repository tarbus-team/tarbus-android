import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus_app/bloc/departure_details_cubit/departure_details_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/departure_wrapper.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/shared/utilities/date_time_utils.dart';
import 'package:tarbus_app/views/widgets/app_bars/custom_app_bar.dart';
import 'package:tarbus_app/views/widgets/app_custom/action_tile.dart';
import 'package:tarbus_app/views/widgets/app_custom/custom_card.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';
import 'package:tarbus_app/views/widgets/generic/no_glov_behaviour.dart';

class DepartureDetailsPage extends StatefulWidget {
  final DepartureWrapper departureWrapper;

  const DepartureDetailsPage({Key? key, required this.departureWrapper})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DepartureDetailsPage();
}

class _DepartureDetailsPage extends State<DepartureDetailsPage> {
  late final Departure departure;

  @override
  void initState() {
    departure = widget.departureWrapper.departure;
    context.read<DepartureDetailsCubit>().getTrackDepartures(departure);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'Szczegóły odjazdu',
      ),
      body: SafeArea(
        child: ScrollConfiguration(
          behavior: NoGlowBehaviour(),
          child: ListView(
            children: [
              CustomCard(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kierunek',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        leading: Icon(
                          Icons.near_me_outlined,
                          size: 19,
                          color: AppColors.of(context).primaryColor,
                        ),
                        visualDensity: VisualDensity.compact,
                        title: Text(departure.destination.directionBoardName),
                      ),
                      Text(
                        'Linia',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        leading: SvgPicture.asset(
                          'assets/icons/icon_bus.svg',
                          color: AppColors.of(context).primaryColor,
                          width: 19,
                          height: 19,
                        ),
                        title: Text(departure.track.route.busLine.name),
                      ),
                      Text(
                        'Wybrany przystanek',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        contentPadding: EdgeInsets.symmetric(horizontal: 0),
                        visualDensity: VisualDensity.compact,
                        leading: SvgPicture.asset(
                          'assets/icons/icon_bus_stop.svg',
                          color: AppColors.of(context).primaryColor,
                          width: 19,
                          height: 19,
                        ),
                        title: Text(departure.busStop.name),
                      ),
                    ],
                  ),
                ),
              ),
              CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Akcje',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    ActionTile(
                        title: 'Zobacz trasę na mapie',
                        onTap: () {
                          context.router.root.push(TrackMapRoute(
                              busStop: departure.busStop,
                              track: departure.track));
                        }),
                  ],
                ),
              ),
              CustomCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Text(
                        'Przystanki na trasie',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    BlocBuilder<DepartureDetailsCubit, DepartureDetailsState>(
                        builder: (context, state) {
                      if (state is DepartureDetailsLoaded) {
                        return _buildDeparturesList(state);
                      }
                      return CenterLoadSpinner();
                    }),
                  ],
                ),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeparturesList(DepartureDetailsLoaded state) {
    int departuresLength = state.departures.length;
    int departureIndex =
        state.departures.indexOf(widget.departureWrapper.departure);
    return ListView.builder(
      itemCount: departuresLength,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        int indexValue = 1;
        if (index == 0) indexValue = 0;
        if (index == departuresLength - 1) indexValue = 2;

        return _buildListItem(
            state.departures[index], departureIndex, index, indexValue);
      },
    );
  }

  Widget _buildListItem(
      Departure departure, int departureIndex, int index, int indexValue) {
    print('$departureIndex,$index');
    bool isTheSameBusStop =
        departure.busStop.id == widget.departureWrapper.departure.busStop.id;
    Map<int, Widget> imageValues = {
      0: SvgPicture.asset(
        'assets/icons/icon_pin_start.svg',
        fit: BoxFit.fitHeight,
      ),
      1: SvgPicture.asset(
        'assets/icons/icon_pin_middle.svg',
        fit: BoxFit.fitHeight,
      ),
      2: SvgPicture.asset(
        'assets/icons/icon_pin_end.svg',
        fit: BoxFit.fitHeight,
      ),
    };

    return InkWell(
      onTap: () {
        context.router.navigate(DeparturesRoute(
          busStopId: departure.busStop.id,
          busStopName: departure.busStop.name,
          busLine: departure.track.route.busLine,
        ));
      },
      child: Container(
        color: isTheSameBusStop ? AppColors.of(context).primaryLight : null,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity(horizontal: 0),
            contentPadding: EdgeInsets.all(0),
            leading: Column(
              children: [
                Expanded(
                  child: imageValues[indexValue]!,
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${DateTimeUtils.parseMinutesToTime(departure.timeInMin)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            minLeadingWidth: 20,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isTheSameBusStop) ...[
                  Text(
                    'Obecny przystanek',
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  Text(
                    '${departure.busStop.name}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ] else ...[
                  Text(
                    '${departure.busStop.name}',
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                  ),
                  if (departureIndex < index)
                    Text(
                      'Z ${widget.departureWrapper.departure.busStop.name} w ${departure.timeInMin - widget.departureWrapper.departure.timeInMin} minut',
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
