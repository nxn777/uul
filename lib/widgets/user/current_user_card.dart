import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/widgets/avatars/bundled_avatar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentUserCard extends StatelessWidget {
  final User user;

  CurrentUserCard({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: kSpacingXXLarge,
          ),
          Row(
            children: [
              FlatButton.icon(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.star,
                    color: kAccentColor,
                  ),
                  label: Text("")),
              BundledAvatar(
                height: kSpacingHuge * 1.5,
                imageSrc: user?.avatarImageSrc == null ? "assets/defaults/default_user3.png" : user.avatarImageSrc,
              ),
              FlatButton.icon(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.star,
                    color: kAccentColor,
                  ),
                  label: Text("")),
            ],
          ),
        ],
      ),
    );
  }
}
