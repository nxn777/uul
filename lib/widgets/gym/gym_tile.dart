import 'package:UUL_Gym/constants/dimens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:UUL_Gym/models/gym.dart';
import 'package:provider/provider.dart';
import 'package:UUL_Gym/models/app_state.dart';
import 'package:UUL_Gym/constants/animation_constants.dart';
import 'package:UUL_Gym/constants/text_style_constants.dart';
import 'package:UUL_Gym/constants/color_constants.dart';

class GymTile extends StatefulWidget {
  final Gym gym;

  GymTile({this.gym});

  @override
  _GymTileState createState() => _GymTileState();
}

class _GymTileState extends State<GymTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(builder: (context, appState, child) {
      return GestureDetector(
          onTap: () {
            Provider.of<AppState>(context, listen: false).changeActiveGym(widget.gym);
          },
          behavior: HitTestBehavior.translucent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, kSpacingMedium, kSpacingHuge, kSpacingSmall),
                child: Text(
                  widget.gym.title,
                  style: _getTextStyle(),
                  textAlign: TextAlign.start,
                ),
              ),
              AnimatedContainer(
                child: SizedBox(width: kSpacingMedium, height: kSpacingXSmall,),
                duration: Duration(milliseconds: kStandardAnimationDurationMS),
                decoration: BoxDecoration(
                  color: _isSelected() ? kAccentColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(kSpacingXSmall),
                ),
              )
            ],
          ));
    });
  }

  bool _isSelected() => Provider.of<AppState>(context, listen: false).activeGym == widget.gym;

  TextStyle _getTextStyle() {
    var _style = _isSelected() ? kRegularActiveTextStyle.copyWith(fontWeight: FontWeight.w900) : kRegularInactiveTextStyle.copyWith(fontWeight: FontWeight.w900);
    return _style;
  }
}
