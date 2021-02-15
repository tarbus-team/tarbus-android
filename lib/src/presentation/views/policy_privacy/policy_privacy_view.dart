import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/src/utils/web_page_utils.dart';

class PolicyPrivacyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [AppBarTitle(title: 'Polityka prywatności')],
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
              Text('1. Licencja\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                '1.1. Używanie aplikacji tarBUS jest bezpłatne\n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              InkWell(
                onTap: () {
                  WebPageUtils.openURL("https://www.facebook.com/dpajak99");
                },
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    text: "1.2. Zabrania się wykorzystywanie aplikacji do celów komercyjnych bez wiedzy i pisemnej zgody",
                    style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.instance(context).mainFontColor),
                    children: <TextSpan>[
                      TextSpan(text: ' osoby zarządzającej projektem\n', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  WebPageUtils.openURL("https://www.facebook.com/dpajak99");
                },
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    text:
                        "1.3. Zabrania się wykorzystywania bazy danych oraz API aplikacji do celów innych niż wyświelanie jej zawartości w aplikacji tarBUS, bez wiedzy i pisemnej zgody",
                    style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.instance(context).mainFontColor),
                    children: <TextSpan>[
                      TextSpan(text: ' osoby zarządzającej projektem\n', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Text(
                '1.3. Twórcy aplikacji tarBUS dołożyli wszelkich starań aby działałaona prawidłowo. Autorzy nie ponoszą jednak w żadnym przypadkujakiejkolwiek odpowiedzialności za szkody pośrednie lub bezpośrednie,poniesione przez użytkownika, bądź osoby trzecie, wynikłe z użytkowania, lub braku możliwości użytkowania oprogramowania, niezależnie od tego, w jaki sposób te szkody powstały i czego dotyczą.\n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text(
                '1.4. Kod źródłowy aplikacji dostępny jest na platformie GitHub, gdzie użytkownicy mogą nieodpłatnie wspomóc rozwój aplikacji.\n',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                ),
              ),
              Text('2. Zbieranie i wykorzystywanie informacji\n', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () async {
                  WebPageUtils.openURL("https://policies.google.com/privacy");
                },
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    text:
                        "2.1.  Aplikacja korzysta z usług stron trzecich, które mogą zbierać informacje używane do identyfikacji użytkownika. \nLinki do polityki prywatności dostawców usług zewnętrznych używanych przez aplikację:\n ",
                    style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.instance(context).mainFontColor),
                    children: <TextSpan>[
                      TextSpan(text: '\n          - Usługi Google Play\n', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Text('\n\n\n\n\n\n\n\n')
            ],
          ),
        ),
      ),
    );
  }
}
