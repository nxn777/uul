import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:common/common.dart';

enum ViewStatus { IDLE, ERROR, LOADING }

class ViewError {
  String message;
  Function retry;

  ViewError({this.message, this.retry});
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

  Widget buildErrorState(VM viewModel, BuildContext context) {
   // _showSnackbar(viewModel, context);
    return Container(
      child: FaIcon(
        FontAwesomeIcons.sadCry,
        size: kSpacingHuge,
        color: kAccentColor,
      ),
    );
  }

  Widget buildErrorStateWithContent(VM viewModel, BuildContext context) {
    //_showSnackbar(viewModel, context);
    return buildIdleState(viewModel, context);
  }

  Widget buildBody(VM viewModel, BuildContext context) {
    print("Building: $viewModel - ${viewModel.viewState.status}");
    Widget body;
    switch (viewModel.viewState.status) {
      case ViewStatus.IDLE:
        body = buildIdleState(viewModel, context);
        break;
      case ViewStatus.ERROR:
        body = viewModel.viewState.value == null ? buildErrorState(viewModel, context) : buildErrorStateWithContent(viewModel, context);
        break;
      case ViewStatus.LOADING:
        body = viewModel.viewState.value == null ? buildLoadingState(viewModel, context) : UULOverlayLoadingIndicator(child: buildIdleState(viewModel, context));
        break;
    }
    return body;
  }
}
