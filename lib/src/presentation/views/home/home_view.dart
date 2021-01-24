import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/api/response/response_welcome_dialog.dart';
import 'package:tarbus2021/src/model/entity/app_start_settings.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/horizontal_line.dart';
import 'package:tarbus2021/src/presentation/views/app_info/app_info_view.dart';
import 'package:tarbus2021/src/presentation/views/bus_lines/bus_lines_view.dart';
import 'package:tarbus2021/src/presentation/views/home/controller/home_view_controller.dart';
import 'package:tarbus2021/src/presentation/views/home/home_button.dart';
import 'package:tarbus2021/src/presentation/views/search/search_view.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeView extends StatefulWidget {
  final AppStartSettings appStartSettings;

  HomeView({this.appStartSettings});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeViewController viewController = HomeViewController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.appStartSettings.hasDialog) {
        _showDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String updateTime = widget.appStartSettings.lastUpdated.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.titleMainView),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.margin_view_horizontally),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/logo_tarbus_menu.png'),
                    height: 80,
                  ),
                ],
              ),
              _buildMessageBox(),
              HorizontalLine(),
              HomeButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => BusLinesView()));
                },
                title: AppString.labelBusLines,
                image: AssetImage("assets/icons/bus_b.png"),
              ),
              HomeButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => SearchView()));
                },
                title: AppString.labelSearchBusStop,
                icon: Icons.search,
              ),
              HomeButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => AppInfoView()));
                },
                title: AppString.labelInfoAboutApp,
                icon: Icons.info,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppDimens.margin_view_horizontally, vertical: 20),
                  child: Text('${AppString.labelLastUpdated} $updateTime', style: TextStyle(fontSize: 12))),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBox() {
    var message = widget.appStartSettings.welcomeMessage.message;
    if (message == null) {
      message = '';
    }
    return Padding(
      padding: EdgeInsets.all(15),
      child: FlatButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            var href = widget.appStartSettings.welcomeMessage.href;
            if (href != null && href != '') {
              launchURL(href);
            }
          },
          child: Markdown(
            data: message,
            shrinkWrap: true,
          )),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _showDialog() async {
    ResponseWelcomeDialog dialogContent = widget.appStartSettings.dialogContent;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: SingleChildScrollView(
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dialogContent.imageHref.isNotEmpty)
                      Image.network(
                        dialogContent.imageHref,
                        height: 50,
                      ),
                    if (dialogContent.title.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          dialogContent.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (dialogContent.content.isNotEmpty)
                      Markdown(
                        padding: EdgeInsets.all(0),
                        data: dialogContent.content,
                        shrinkWrap: true,
                      ),
                    if (dialogContent.hasButtonLink)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          decoration: new BoxDecoration(
                            color: AppColors.lightgray,
                          ),
                          child: ButtonTheme(
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            minWidth: 0,
                            height: 0,
                            child: FlatButton(
                              onPressed: () {
                                launchURL(dialogContent.buttonLinkHref);
                              },
                              child: Text(
                                dialogContent.buttonLinkContent,
                                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          if (dialogContent.hasButtonClose)
            FlatButton(
              onPressed: () {
                viewController.addDialogToList(dialogContent.id);
                Navigator.of(context).pop();
              },
              child: Text(AppString.labelNeverShowAgain),
            ),
          if (dialogContent.hasButtonRemindMeLater)
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(AppString.labelRemindMeLater),
            ),
        ],
      ),
    );
  }
}
