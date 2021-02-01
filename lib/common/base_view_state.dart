import 'package:UUL_Gym/widgets/indicator/u_u_l_loading_indicator.dart';
import 'package:UUL_Gym/widgets/indicator/u_u_l_overlay_loading_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

mixin ViewStateField<T> implements ChangeNotifier {
  ViewState<T> viewState;
}

mixin ViewStateScreen<VM extends ViewStateField> {
  VM Function(BuildContext) vmCreator() {
    return (ctx) => null;
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider<VM>(
      create: vmCreator(),
      child: Consumer<VM>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: SafeArea(
              child: buildBody(viewModel, context),
            ),
          );
        },
      ),
    );
  }

  Widget buildIdleState(VM viewModel, BuildContext context);

  Widget buildLoadingState(VM viewModel, BuildContext context) => Container(
        child: Center(
          child: UULLoadingIndicator(),
        ),
      );

  Widget buildErrorState(VM viewModel, BuildContext context) => null;

  Widget buildBody(VM viewModel, BuildContext context) {
    print("Building: $viewModel - ${viewModel.viewState.status}");
    Widget body;
    switch (viewModel.viewState.status) {
      case ViewStatus.IDLE:
        body = buildIdleState(viewModel, context);
        break;
      case ViewStatus.ERROR:
        body = buildErrorState(viewModel, context);
        break;
      case ViewStatus.LOADING:
        body = viewModel.viewState.value == null ? buildLoadingState(viewModel, context) : UULOverlayLoadingIndicator(child: buildIdleState(viewModel, context));
        break;
    }
    return body;
  }
}
