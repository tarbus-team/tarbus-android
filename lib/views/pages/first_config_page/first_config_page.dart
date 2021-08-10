import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/first_config_cubit/first_config_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/available_version_model.dart';
import 'package:tarbus_app/data/model/available_versions_response.dart';
import 'package:tarbus_app/views/pages/first_config_page/first_config_page_list_item.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';
import 'package:tarbus_app/views/widgets/generic/center_text.dart';
import 'package:tarbus_app/views/widgets/generic/message_spinner.dart';

class FirstConfigPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstConfigPage();
}

class _FirstConfigPage extends State<FirstConfigPage> {
  List<AvailableVersionModel> selectedVersions = List.empty(growable: true);

  @override
  void initState() {
    context.read<FirstConfigCubit>().fetchAvailableVersions(context);
    super.initState();
  }

  Widget _buildVersionList(AvailableVersionsResponse versionModel) {
    return Column(
      children: [
        if (versionModel.note != null)
          Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: Text(
              versionModel.note!,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: MediaQuery.of(context).size.height * 0.50,
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.of(context).borderColor,
              width: 1,
            ),
          ),
          child: ListView.builder(
            itemCount: versionModel.availableVersions!.length,
            itemBuilder: (context, index) {
              return FirstConfigPageListItem(
                  onSelect: (version, status) {
                    if (status) {
                      selectedVersions.add(version);
                    } else {
                      selectedVersions.removeWhere((element) =>
                          element.subscribeCode == version.subscribeCode);
                    }
                  },
                  versionModel: versionModel.availableVersions![index]);
            },
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.90,
          margin: EdgeInsets.symmetric(vertical: 5),
          child: ElevatedButton(
            onPressed: () {
              context
                  .read<FirstConfigCubit>()
                  .saveVersions(context, selectedVersions);
            },
            child: Text('Potwierdź'),
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadingMessage() {
    return Center(
      child: MessageSpinner(
        message: 'Pobieranie rozkładów jazdy',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                child: CenterText(
                  'Wybierz przewoźnika',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              CenterText(
                  'Możesz później zmienić tą opcję \n w ustawieniach aplikacji'),
              SizedBox(
                height: 15,
              ),
              BlocConsumer<FirstConfigCubit, FirstConfigState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is FirstConfigLoaded) {
                    return _buildVersionList(
                        state.props[0] as AvailableVersionsResponse);
                  } else if (state is FirstConfigDownloading) {
                    return _buildDownloadingMessage();
                  } else {
                    return CenterLoadSpinner();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
