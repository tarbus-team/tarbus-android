import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/horizontal_line.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.titleAboutApplication),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/logo_tarbus_main_b.png'),
                    height: 200,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                child: Text('${AppString.labelInfoAboutApp}:', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text(AppString.textAppDescription),
              HorizontalLine(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                child: Text(AppString.labelAboutUs, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text(AppString.textAboutUs),
              HorizontalLine(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                child: Text(AppString.labelContact, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Text(AppString.textContact, style: TextStyle()),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          onPressed: () {
                            final Uri _emailLaunchUri = Uri(scheme: 'mailto', path: 'dominik00801@gmail.com', queryParameters: {'subject': 'Tarbus'});
                            launchURL(_emailLaunchUri.toString());
                          },
                          padding: EdgeInsets.all(0),
                          child: Image(
                            image: AssetImage('assets/icons/social_mail.png'),
                            height: 50,
                          ),
                        ),
                        FlatButton(
                            onPressed: () {
                              launchURL("https://www.linkedin.com/in/dominikpajak/");
                            },
                            child: Image(
                              image: AssetImage('assets/icons/social_ln.png'),
                              height: 50,
                            )),
                        FlatButton(
                            onPressed: () {
                              launchURL("https://github.com/dpajak99/tarbus2021");
                            },
                            child: Image(
                              image: AssetImage('assets/icons/social_gh.png'),
                              height: 50,
                            )),
                        FlatButton(
                            onPressed: () {
                              launchURL("https://www.facebook.com/dpajak99");
                            },
                            child: Image(
                              image: AssetImage('assets/icons/social_fb.png'),
                              height: 50,
                            )),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 0, 15),
                      child: Text(AppString.appInfoVersion, style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
