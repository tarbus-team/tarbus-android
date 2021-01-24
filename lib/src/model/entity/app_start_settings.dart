import '../api/response/response_last_updated.dart';
import '../api/response/response_welcome_dialog.dart';
import '../api/response/response_welcome_message.dart';

class AppStartSettings {
  bool isOnline = false;
  bool hasDialog = false;
  ResponseWelcomeDialog dialogContent = ResponseWelcomeDialog();
  ResponseWelcomeMessage welcomeMessage = ResponseWelcomeMessage.offline();
  ResponseLastUpdated lastUpdated;
}
