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

  ReviewInfo(this.name, this.login, this.apartmentCode);
}

abstract class HasReviewInfo {
  ReviewInfo get reviewInfo;
}