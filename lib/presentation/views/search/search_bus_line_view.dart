import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/app/app_dimens.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/entity/bus_line.dart';
import 'package:tarbus2021/presentation/views/search/search_item_bus_line.dart';

import 'controller/search_bus_stop_view_controller.dart';

class SearchBusLineView extends StatefulWidget {
  static const route = '/search/busStops';
  final bool showFavouritesButton;

  const SearchBusLineView({Key key, this.showFavouritesButton = false}) : super(key: key);

  @override
  _SearchBusLineViewState createState() => _SearchBusLineViewState();
}

class _SearchBusLineViewState extends State<SearchBusLineView> {
  final SearchBusLineViewController viewController = SearchBusLineViewController();
  List<BusLine> busLineList = <BusLine>[];
  final _inputNode = FocusNode();

  void openKeyboard() {
    FocusScope.of(context).requestFocus(_inputNode);
  }

  void closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void update(String text) async {
    busLineList = await viewController.getSearchedBusLineList(text);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: _buildSearchField(),
        ),
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
            itemCount: busLineList.length,
            itemBuilder: (BuildContext context, int index) {
              var busLine = busLineList[index];
              return SearchItemBusLine(busLine: busLine, showFavouritesButton: widget.showFavouritesButton);
            },
          ),
        ),
      );
    } else {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/icon_bus.svg',
              width: 80,
              height: 80,
              color: AppColors.instance(context).iconColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              AppString.labelStartWriteToSearchBusLine,
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
          hintText: AppString.labelSearchInputBusLine,
          hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
        ),
      ),
    );
  }
}
