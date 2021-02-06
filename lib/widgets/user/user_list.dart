import 'package:common/common.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/widgets/user/user_card.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  final void Function(User) onUserTap;
  final List<User> users;
  final int activeUserId;
  final bool insideListView;

  UserList({this.onUserTap, this.users, this.activeUserId, this.insideListView = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: kSpacingMedium, bottom: kSpacingXXLarge),
      shrinkWrap: insideListView ? true : false,
      physics: insideListView ? ClampingScrollPhysics() : null,
      itemBuilder: (context, index) => UserCard(
        users[index],
        activeUserId,
        onTap: onUserTap,
      ),
      itemCount: users.length,
    );
  }
}
