import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/utils/web_page_utils.dart';

class AboutUsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [AppBarTitle(title: 'O aplikacji')],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: SvgPicture.asset(
                  'assets/logo_tarbus_header.svg',
                  width: 55,
                  height: 55,
                  color: AppColors.instance(context).homeLinkColor,
                ),
              ),
              Text('O aplikacji\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                'Rozkład jazdy dla nowych linii autobusowych wyjeżdżających poza granice Tarnowa. Aplikacja została stworzona została z myślą o tych mieszkańcach okolic Tarnowa, co na co dzień przyzwyczajeni byli do dosyć nowoczesnych rozwiązań oferowanych przez linie miejskie, a przez zmianę na prywatnego przewoźnika - całkowicie stracili do nich dostęp.\n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text('Autorzy\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                'Jesteśmy małą grupką uczniów i studentów z tarnowskich szkół.Chcemy pomóc mieszkańcom naszych miejscowości w codziennym życiu. Naszym pierwszym projektem jest aplikacja tarBUS, która wspomaga i upraszcza podróże komunikacją zbiorową na terenie miasta i gmin ościennych. Nasza idea przewodnia: Razem możemy uczynić nasze miasto lepszym miejscem!  \n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text('Kontakt z dewelpperem\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                'Znalazłeś błąd? Masz pytania odnośnie działania aplikacji? Za dział Android odpowiada Dominik  \n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Container(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL("https://www.facebook.com/dpajak99");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/icons/social_fb.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL("https://www.linkedin.com/in/dominikpajak/");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/icons/social_ln.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL("mailto:dominik00801@gmail.com");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/icons/social_mail.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL("https://github.com/dpajak99");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/icons/social_gh.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Współpraca\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                'Chciałbyś wspomóc rozwój aplikacji? Zapraszamy do kontaktu!  \n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Container(
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL("https://www.facebook.com/tarbus2021");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/icons/social_fb.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL("mailto:dominik00801@gmail.com");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/icons/social_mail.png"),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        WebPageUtils.openURL("https://github.com/dpajak99/tarbus2021");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset("assets/icons/social_gh.png"),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
