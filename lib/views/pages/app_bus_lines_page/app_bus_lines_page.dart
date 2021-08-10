import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/bus_lines_cubit/bus_lines_cubit.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/data/model/schedule/company.dart';
import 'package:tarbus_app/views/pages/app_bus_lines_page/bus_lines_list_item.dart';
import 'package:tarbus_app/views/widgets/app_custom/custom_card.dart';
import 'package:tarbus_app/views/widgets/generic/pretty_scroll_view.dart';

class AppBusLinesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppBusLinesPage();
}

class _AppBusLinesPage extends State<AppBusLinesPage> {
  @override
  void initState() {
    context.read<BusLinesCubit>().getAll();
    super.initState();
  }

  Widget _buildBusLinesListView(List<Map<String, dynamic>> data) {
    return ListView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CustomCard(
              child: BusLinesListItem(
            company: data[index]["company"] as Company,
            busLines: data[index]["lines"] as List<BusLine>,
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return PrettyScrollView(
      subTitle: null,
      title: 'Linie',
      body: BlocBuilder<BusLinesCubit, BusLinesState>(
        builder: (context, state) {
          if (state is BusLinesLoaded) {
            return _buildBusLinesListView(state.data);
          }
          return Text('Loading');
        },
      ),
    );
  }
}
