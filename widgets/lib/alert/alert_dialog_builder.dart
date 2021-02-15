import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlertDialogBuilder {
  final BuildContext _context;
  String _message = "";
  String _title = "";
  final List<FlatButton> _actions = [];

  AlertDialogBuilder(this._context);

  AlertDialogBuilder setMessage(String message) {
    this._message = message;
    return this;
  }

  AlertDialogBuilder setTitle(String title) {
    this._title = title;
    return this;
  }

  AlertDialogBuilder addAction(String text, {bool isDestructive = false, Function onPressed}) {
    _actions.add(
      FlatButton(
        onPressed: () {
          onPressed?.call();
          Navigator.of(_context).pop();
        },
        child: Text(
          text,
          style: isDestructive ? kRegularDestructiveLinkTextStyle : kRegularActiveLinkTextStyle,
        ),
      ),
    );
    return this;
  }

  AlertDialogBuilder addCancel() {
    return addAction("Cancel");
  }

  AlertDialog build() {
    return AlertDialog(
      title: Text(
        _title,
        style: kCaptionActiveTextStyle,
      ),
      content: Text(
        _message,
        style: kRegularActiveTextStyle,
      ),
      actions: _actions,
    );
  }

  void buildAndShow() {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return build();
      },
    );
  }
}
