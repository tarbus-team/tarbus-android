import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/presentation/views/search/search_item_bus_stop.dart';

import 'controller/search_bus_line_view_controller.dart';

class SearchBusStopView extends StatefulWidget {
  static const route = '/search/busStops';
  final bool showFavouritesButton;

  const SearchBusStopView({Key key, this.showFavouritesButton = false}) : super(key: key);

  @override
  _SearchBusStopViewState createState() => _SearchBusStopViewState();
}

class _SearchBusStopViewState extends State<SearchBusStopView> {
  final SearchBusStopViewController viewController = SearchBusStopViewController();
  List<BusStop> busStopList = <BusStop>[];
  var _inputNode = FocusNode();

  void openKeyboard() {
    FocusScope.of(context).requestFocus(_inputNode);
  }

  void closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void update(String text) async {
    busStopList = await viewController.getSearchedBusStops(text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: PreferredSize(child: _buildSearchField(), preferredSize: Size.fromHeight(kToolbarHeight)),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (viewController.searchStatus) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimens.margin_view_horizontally),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: busStopList.length,
            itemBuilder: (BuildContext context, int index) {
              var busStop = busStopList[index];
              return SearchItemBusStop(busStop: busStop, showFavouritesButton: widget.showFavouritesButton);
            },
          ),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/icon_bus_stop.svg',
              width: 80,
              height: 80,
              color: AppColors.instance(context).iconColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppString.labelStartWriteToSearchBusStop,
              maxLines: 2,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally),
      child: TextFormField(
        autofocus: true,
        focusNode: _inputNode,
        onChanged: (text) {
          viewController.startSearch(text);
          update(text);
        },
        cursorColor: Theme.of(context).primaryColor,
        showCursor: true,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppString.labelSearchInputBusStop,
          hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
        ),
      ),
    );
  }
}
