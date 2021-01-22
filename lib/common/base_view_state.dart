import 'package:flutter/cupertino.dart';

enum ViewStatus { IDLE, ERROR, LOADING }

class ViewError {
  String message;
  Function retry;
}

class ViewState<T> {
  T value;
  ViewStatus status;
  ViewError error;

  ViewState<T> copyWith({T value, ViewStatus status, ViewError error}) {
    return ViewState<T>(value: value ?? this.value, status: status ?? this.status, error: error ?? this.error);
  }

  ViewState({this.value, @required this.status, this.error});
}
