import 'package:flutter/cupertino.dart';
import 'package:tarbus_app/views/widgets/generic/load_spinner.dart';

class MessageSpinner extends StatelessWidget {
  final String message;

  const MessageSpinner({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoadSpinner(),
        Text(
          message,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
