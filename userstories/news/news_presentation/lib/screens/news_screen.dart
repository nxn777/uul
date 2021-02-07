import 'package:flutter/material.dart';
import 'package:widgets/widgets.dart';

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
