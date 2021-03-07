import 'package:flutter/foundation.dart';
import 'package:i18n/i18n.dart';

mixin AvatarSelection on ChangeNotifier {
  String activeAvatarImage;

  void changeActiveAvatarImage(String image) {
    this.activeAvatarImage = image;
    notifyListeners();
  }
}

class ReviewInfo {
  final String name;
  final String login;
  final String apartmentCode;
  final String reviewStepTitle;
  final String reviewMessage;
  ReviewInfo(this.name, this.login, this.apartmentCode, this.reviewStepTitle, {String reviewMsg})
      : reviewMessage = reviewMsg != null
            ? reviewMsg
            : "Your profile will be saved on a server, you will need to visit Uno Urban Life administration in person to activate it.\nPlease remember your login.".i18n;
}

abstract class HasReviewInfo {
  ReviewInfo get reviewInfo;
}
