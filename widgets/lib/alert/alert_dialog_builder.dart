import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:i18n/i18n.dart';

class AlertDialogBuilder {
  final BuildContext _context;
  String _message = "";
  String _title = "";
  Widget _textfield;
  final List<FlatButton> _actions = [];

  AlertDialogBuilder(this._context);

  AlertDialogBuilder setMessage(String message) {
    this._message = message;
    return this;
  }

  AlertDialogBuilder setTextField(String hint, {@required void Function(String) valueChanged}) {
    _textfield = TextFormField(
      decoration: InputDecoration(labelText: hint),
      obscureText: true,
      onChanged: valueChanged,
    );
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
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
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
    return addAction("Cancel".i18n);
  }

  AlertDialog build() {
    return AlertDialog(
      title: Text(
        _title,
        style: kCaptionActiveTextStyle,
      ),
      content: _textfield == null
          ? Text(
              _message,
              style: kRegularActiveTextStyle,
            )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _message,
            style: kRegularActiveTextStyle,
          ),
          _textfield
        ],
      ),
      actions: _actions,
    );
  }

  void buildAndShow() {
    if (_textfield != null) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ]);
    }
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return build();
      },
    );
  }
}
