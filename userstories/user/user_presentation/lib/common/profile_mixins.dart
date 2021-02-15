import 'package:flutter/foundation.dart';

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
  ReviewInfo(this.name, this.login, this.apartmentCode, this.reviewStepTitle,
      {this.reviewMessage =
          "Your profile will be saved on a server, you will need to visit Uno Urban Life administration in person to activate it.\nPlease remember your login and name."});
}

abstract class HasReviewInfo {
  ReviewInfo get reviewInfo;
}
