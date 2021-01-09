import 'package:UUL_Gym/common/has_title.dart';
import 'package:UUL_Gym/constants/animation_constants.dart';
import 'package:UUL_Gym/constants/color_constants.dart';
import 'package:UUL_Gym/constants/dimens.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalSelectorTile<T extends HasTitle> extends StatefulWidget {
  final T item;
  final Function onTap;
  final bool isSelected;
  HorizontalSelectorTile({@required this.item, @required this.onTap, @required this.isSelected});

  @override
  _HorizontalSelectorTileState createState() => _HorizontalSelectorTileState();
}

class _HorizontalSelectorTileState extends State<HorizontalSelectorTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap(widget.item);
        },
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, kSpacingMedium, kSpacingHuge, kSpacingSmall),
              child: Text(
                widget.item.getTitle(),
                style: _getTextStyle(),
                textAlign: TextAlign.start,
              ),
            ),
            AnimatedContainer(
              child: SizedBox(
                width: kSpacingMedium,
                height: kSpacingXSmall,
              ),
              duration: Duration(milliseconds: kStandardAnimationDurationMS),
              decoration: BoxDecoration(
                color: widget.isSelected ? kAccentColor : Colors.transparent,
                borderRadius: BorderRadius.circular(kSpacingXSmall),
              ),
            )
          ],
        ));
  }

  TextStyle _getTextStyle() {
    var _style = widget.isSelected ? kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.w900) : kRegularInactiveTextStyle.copyWith(fontWeight: FontWeight.w900);
    return _style;
  }
}