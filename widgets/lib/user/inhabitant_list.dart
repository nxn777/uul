import 'package:common/common.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'inhabitant_card.dart';

class InhabitantList extends StatelessWidget {
  final void Function(Inhabitant) onInhabitantTap;
  final void Function(Inhabitant) onMakeInhabitantActiveTap;
  final List<Inhabitant> inhabitants;
  final int activeInhabitantId;
  final bool insideListView;

  InhabitantList({this.onInhabitantTap, this.onMakeInhabitantActiveTap, @required this.inhabitants, this.activeInhabitantId, this.insideListView = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: kSpacingMedium, bottom: kSpacingXXLarge),
      shrinkWrap: insideListView ? true : false,
      physics: insideListView ? ClampingScrollPhysics() : null,
      itemBuilder: (context, index) => InhabitantCard(
        inhabitants[index],
        activeInhabitantId,
        onTap: onInhabitantTap,
        onMakeActiveTap: onMakeInhabitantActiveTap,
      ),
      itemCount: inhabitants.length,
    );
  }
}
