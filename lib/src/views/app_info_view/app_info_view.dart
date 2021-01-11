import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/widgets/horizontal_line.dart';
import 'package:url_launcher/url_launcher.dart';

class AppInfoView extends StatelessWidget {
  String appDescription = "Aplikacja tarBUS to mobilny rozkład jazdy dla nowych, pozamiejskich linii autobusowych. Stworzona z myślą o tych "
      "mieszkańcach okolic Tarnowa, co na co dzień przyzwyczajeni byli do dosyć nowoczesnych rozwiązań oferowanych nam przez linie miejskie, a przez "
      "zmianę na prywatnego przewoźnika - całkowicie stracili do nich dostęp.\n";
  String aboutUs = "Jesteśmy małą grupą głównie uczniów, studentów z Tarnowskich szkół. Chcemy pomóc mieszkańcom naszych miejscowości "
      "korzystającym z komunikacji publicznej w codziennych dojazdach zarówno do miasta jak i z miasta, dlatego też wspólnie stworzyliśmy narzędzie "
      "znacznie upraszczające nam chociażby sprawdzenie godzin odjazdu autobsu. Idea przewodnia: Razem możemy sprawić nasze miasto lepszym "
      "miejscem!\n";

  String kontakt = "Znalazłeś błąd? Chcesz podzielić się opinią, pomysłem na rozwój lub współpracę? Napisz do nas!\n\n";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacje o aplikacji'),
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
                child: Text('Informacje o aplikacji:', style: TextStyle(fontFamily: 'Asap', fontWeight: FontWeight.bold)),
              ),
              Text(appDescription, style: TextStyle(fontFamily: 'Asap')),
              HorizontalLine(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                child: Text('O nas:', style: TextStyle(fontFamily: 'Asap', fontWeight: FontWeight.bold)),
              ),
              Text(aboutUs, style: TextStyle(fontFamily: 'Asap')),
              HorizontalLine(),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 15),
                child: Text('Kontakt:', style: TextStyle(fontFamily: 'Asap', fontWeight: FontWeight.bold)),
              ),
              Text(kontakt, style: TextStyle(fontFamily: 'Asap')),
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
                      child: Text('Wersja aplikacji: 2.0.0', style: TextStyle(fontFamily: 'Asap', fontWeight: FontWeight.bold)),
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
    } else {
      throw 'Could not launch $url';
    }
  }
}
