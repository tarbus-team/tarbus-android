import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus_app/bloc/app_cubit/app_cubit.dart';
import 'package:tarbus_app/bloc/favourite_cubit/favourite_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_line_model.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';
import 'package:tarbus_app/views/pages/app_home_page/favourite_bus_line_list_item.dart';
import 'package:tarbus_app/views/pages/app_home_page/favourite_bus_stop_list_item.dart';
import 'package:tarbus_app/views/widgets/app_custom/custom_card.dart';
import 'package:tarbus_app/views/widgets/generic/image_card.dart';
import 'package:tarbus_app/views/widgets/generic/pretty_scroll_view.dart';

class AppHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppHomePage();
}

class _AppHomePage extends State<AppHomePage> {
  @override
  void initState() {
    context.read<FavouriteBusStopsCubit>().getFavourites();
    context.read<FavouriteBusLinesCubit>().getFavourites();
    super.initState();
  }

  Widget _buildListItem(
      {required Widget icon, required String title, required Function onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
          color: AppColors.of(context).borderColor,
          width: 1,
        ))),
        child: ListTile(
          dense: true,
          minLeadingWidth: 20,
          leading: icon,
          title: Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.headline3!.copyWith(
                fontSize: 13, color: AppColors.of(context).primaryColor),
          ),
        ),
      ),
    );
  }

  String _getSubtitle() {
    AppNetworkStatus status = context.read<AppCubit>().appNetworkStatus;
    if (status == AppNetworkStatus.ONLINE) {
      return 'ONLINE';
    }
    return 'OFFLINE';
  }

  @override
  Widget build(BuildContext context) {
    return PrettyScrollView(
      subTitle: _getSubtitle(),
      title: 'tarBUS',
      body: Column(
        children: [
          CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                  child: Text(
                    'Ulubione linie autobusowe'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                BlocBuilder<FavouriteBusLinesCubit, FavouriteState>(
                  builder: (context, state) {
                    if (state is FavouriteBusLinesLoaded) {
                      List<SavedBusLineModel> lines = state.busLines;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: lines.length,
                          itemBuilder: (context, index) {
                            return FavouriteBusLineListItem(
                              busLine: lines[index],
                              isLast: index == lines.length - 1,
                            );
                          });
                    }
                    return SizedBox();
                  },
                ),
                _buildListItem(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_circle_add.svg',
                  ),
                  title: 'Dodaj',
                  onTap: () {
                    context.router.navigate(SearchListRoute(type: 'bus_line'));
                  },
                ),
                _buildListItem(
                  icon:
                      SvgPicture.asset('assets/icons/icon_circle_details.svg'),
                  title: 'Zobacz wszystkie',
                  onTap: () {},
                ),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                  child: Text(
                    'Ulubione przystanki autobusowe'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                BlocBuilder<FavouriteBusStopsCubit, FavouriteState>(
                    builder: (context, state) {
                  if (state is FavouriteBusStopLoaded) {
                    List<SavedBusStopModel> stops = state.busStops;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: stops.length,
                        itemBuilder: (context, index) {
                          return FavouriteBusStopListItem(
                            busStop: stops[index],
                            isLast: index == stops.length - 1,
                          );
                        });
                  }
                  return SizedBox();
                }),
                _buildListItem(
                  icon: SvgPicture.asset(
                    'assets/icons/icon_circle_add.svg',
                  ),
                  title: 'Dodaj',
                  onTap: () {
                    context.router.navigate(
                      SearchListRoute(type: 'bus_stop'),
                    );
                  },
                ),
                _buildListItem(
                  icon:
                      SvgPicture.asset('assets/icons/icon_circle_details.svg'),
                  title: 'Zobacz wszystkie',
                  onTap: () {},
                ),
              ],
            ),
          ),
          CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
                  child: Text(
                    'Społeczność'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Container(
                  height: 310,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ImageCard(
                        logo: SvgPicture.asset(
                            'assets/images/logo_buy_me_a_coffe.svg'),
                        title: 'Kup nam kawę',
                        description:
                            'tarBUS powstał, aby ułatwić nam codzienne przejazdy komunikacją publiczną. Jeżeli podoba Ci się nasza praca, możesz nas wesprzeć poprzez symboliczną wpłatę',
                        backgroundColor: Color(0xffffde59),
                      ),
                      ImageCard(
                        logo: SvgPicture.asset(
                          'assets/images/logo_facebook.svg',
                          color: Colors.white,
                        ),
                        title: 'Jesteśmy na facebooku',
                        description:
                            'Polub nas, aby być na bieżąco z informacjami na temat aplikacji, aktualizacji i zmian',
                        backgroundColor: Color(0xff3c5a98),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
