import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';


Future<void> initUniLinks() async {
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    linkStream.listen((String? link) {
      print("Opened: $link");
    });
  } on PlatformException {
    // Handle exception by warning the user their action did not succeed
    // return?
  }
}
