import 'package:UUL_Gym/models/appartment.dart';
import 'package:UUL_Gym/models/user.dart';
import 'package:UUL_Gym/widgets/indicator/u_u_l_loading_indicator.dart';
import 'package:UUL_Gym/widgets/user/user_card.dart';
import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(child: UULLoadingIndicator()),
        ),
      ),
    );
  }
}

//UserCard(User(id: 0, name: "Username", pwdHash: "pwd", appartment: Appartment(id: 0, code: "C1207"), isActivated: true), 0)//