import 'package:url_launcher/url_launcher.dart';

class WebPageUtils {
  static void openURL(String url) async {
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
