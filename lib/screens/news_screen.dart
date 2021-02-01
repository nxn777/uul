import 'package:UUL_Gym/widgets/indicator/u_u_l_loading_indicator.dart';
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

