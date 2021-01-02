import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_item.dart';
import 'package:tarbus2021/src/widgets/legend_item.dart';

class ScheduleView extends StatelessWidget {
  final BusStop busStop;

  const ScheduleView({Key key, this.busStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rozkład jazdy"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Color.fromRGBO(34, 150, 243, 1),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                busStop.name,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Departure>>(
              //Fetching all the persons from the list using the istance of the DatabaseHelper class
              future: DatabaseHelper.instance.getDeparturesByBusStopId(busStop.number),
              builder: (BuildContext context, AsyncSnapshot<List<Departure>> snapshot) {
                //Checking if we got data or not from the DB
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Departure departure = snapshot.data[index];
                      departure.busStop = busStop;
                      return ScheduleItemView(departure: departure);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LegendItem("C -", " kursuje w soboty, niedziele i święta"),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                LegendItem("K -", " kursuje jeżeli dzień poprzedni nie był dniem wolnym od pracy (świętem)"),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                LegendItem("Y -", " kursuje jeżeli kurs nie rozpoczyna się w dzień wolny od  pracy i święta"),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                LegendItem("D -", " kursuje od poniedziałku do piątku oprócz świąt"),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                LegendItem("S", " - kursuje w dni nauki szkolnej"),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                LegendItem("2-6 -", " kursuje od wtorku do soboty"),
                Container(
                  color: Colors.grey,
                  height: 1,
                ),
                LegendItem("x/y -", " kursuje z dnia x na dzień y"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
