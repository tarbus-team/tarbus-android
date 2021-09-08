import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/favourite_cubit/favourite_cubit.dart';
import 'package:tarbus_app/bloc/search_cubit/search_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';
import 'package:tarbus_app/views/widgets/app_bars/sheet_appbar.dart';
import 'package:tarbus_app/views/widgets/app_custom/custom_card.dart';

class AddFavouriteBusStopPage extends StatelessWidget {
  final BusStop busStop;

  AddFavouriteBusStopPage({Key? key, required this.busStop}) : super(key: key);

  final TextEditingController nameController = TextEditingController();

  Widget _buildFastResponseChip(String value) {
    return GestureDetector(
      onTap: () {
        nameController.text = value;
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Chip(
          label: Text(value.toUpperCase()),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SheetAppBar(
        title: 'Dodaj przystanek',
        onDone: () async {
          await context
              .read<FavouriteBusStopsCubit>()
              .addToFavourites(SavedBusStopModel(
                id: busStop.id,
                userBusStopName: nameController.text,
                realBusStopName: busStop.name,
                destinations: busStop.destinations,
              ));
          await context.read<FavouriteBusStopsCubit>().getFavourites();
          await context.read<SearchCubit>().refresh();
          context.router.pop();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Pomyślnie dodano przystanek do ulubionych'),
          ));
        },
      ),
      body: ListView(
        children: [
          CustomCard(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    busStop.name,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontSize: 18,
                          color: AppColors.of(context).fontColor,
                        ),
                  ),
                  Text(busStop.destinations),
                ],
              ),
            ),
          ),
          CustomCard(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Podpowiedzi nazwy:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 30,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildFastResponseChip('Dom'),
                        _buildFastResponseChip('Praca'),
                        _buildFastResponseChip('Szkoła'),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Twoja nazwa przystanku',
                      hintText: 'Wprowadź nazwę',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
