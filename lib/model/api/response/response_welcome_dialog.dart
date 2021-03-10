class ResponseWelcomeDialog {
  int id = 0;
  String title = '';
  String imageHref = '';
  String content = '';
  String buttonLinkContent = '';
  String buttonLinkHref = '';
  bool hasButtonLink = false;
  bool hasButtonClose = false;
  bool hasButtonRemindMeLater = false;

  ResponseWelcomeDialog(
      {this.id,
      this.title,
      this.imageHref,
      this.content,
      this.buttonLinkHref,
      this.buttonLinkContent,
      this.hasButtonLink,
      this.hasButtonClose,
      this.hasButtonRemindMeLater});

  factory ResponseWelcomeDialog.fromJson(Map<String, dynamic> json) {
    var _hasButtonLink = false;
    var _hasButtonClose = false;
    var _hasButtonRemindMeLater = false;

    if (json['has_button_link'] == 1) {
      _hasButtonLink = true;
    }
    if (json['has_button_close'] == 1) {
      _hasButtonClose = true;
    }
    if (json['has_button_remind_me_later'] == 1) {
      _hasButtonRemindMeLater = true;
    }

    return ResponseWelcomeDialog(
        id: json['id'] as int,
        title: json['title'] as String,
        imageHref: json['image_href'] as String,
        content: json['content'] as String,
        buttonLinkHref: json['button_link_href'] as String,
        buttonLinkContent: json['button_link_content'] as String,
        hasButtonLink: _hasButtonLink,
        hasButtonClose: _hasButtonClose,
        hasButtonRemindMeLater: _hasButtonRemindMeLater);
  }

  @override
  String toString() {
    return 'AppAlertDialogContent{id: $id, title: $title, imageHref: $imageHref, content: $content, buttonLinkContent: $buttonLinkContent, buttonLinkHref: $buttonLinkHref, hasButtonLink: $hasButtonLink, hasButtonClose: $hasButtonClose, hasButtonRemindMeLater: $hasButtonRemindMeLater}';
  }
}
