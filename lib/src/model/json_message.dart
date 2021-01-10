class JsonMessage {
  String message;

  JsonMessage({this.message});

  factory JsonMessage.fromJson(Map<String, dynamic> json) => JsonMessage(message: json['message']);
}
