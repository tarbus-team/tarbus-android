import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/views/search_view/controller/search_view_controller.dart';
import 'package:tarbus2021/src/views/search_view/search_item.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewController viewController = SearchViewController();

  @override
  void dispose() {
    viewController.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          bottom: PreferredSize(child: _buildSearchField(), preferredSize: Size.fromHeight(kToolbarHeight)),
          title: Text(
            'Szukaj',
            style: TextStyle(fontFamily: 'Asap', fontWeight: FontWeight.bold),
          )),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (viewController.searchStatus) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimens.margin_view_horizontally),
          child: FutureBuilder<List<BusStop>>(
            future: viewController.getSearchedBusStops(viewController.searchValue),
            builder: (BuildContext context, AsyncSnapshot<List<BusStop>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var busStop = snapshot.data[index];
                    return SearchItem(busStop: busStop);
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.all(15),
        child: Text(
          'Zacznij wpisywać tekst aby wyszukać przystanek',
          style: TextStyle(fontFamily: 'Asap'),
          maxLines: 2,
        ),
      );
    }
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally),
      child: TextField(
        focusNode: viewController.focusNode,
        onChanged: (text) {
          setState(() {
            viewController.searchBusStop(text);
          });
        },
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Asap'),
        decoration: InputDecoration(
          suffixIcon: Icon(Icons.search, color: Colors.white),
          hintText: 'Wpisz nazwę przystanku',
          hintStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontFamily: 'Asap'),
        ),
      ),
    );
  }
}
