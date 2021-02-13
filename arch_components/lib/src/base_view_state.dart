import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widgets/widgets.dart';

enum ViewStatus { IDLE, ERROR, LOADING }

class ViewError {
  final String message;
  final Function retry;
  final Function cancel;
  final bool canCancel;
  ViewError({this.message, @required this.retry, this.canCancel = false, this.cancel});
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
  void notifyAll() => notifyListeners();
}

mixin DefaultErrorResponseHandlers<T> on ViewStateField<T> {
  void showNeedLogin() {
    throw UnimplementedError("Show need login for $this is not implemented");
  }

  void showNetworkError(Function retry, {String message}) {
    if (viewState.value != null) {
      viewState = viewState.copyWith(
        status: ViewStatus.ERROR,
        error: ViewError(
          message: message,
          retry: retry,
          canCancel: true,
          cancel: () {
            viewState = viewState.copyWith(status: ViewStatus.IDLE, error: null);
            notifyListeners();
          },
        ),
      );
    } else {
      viewState = viewState.copyWith(
        status: ViewStatus.ERROR,
        error: ViewError(
          message: message,
          retry: retry,
        ),
      );
    }
    notifyListeners();
  }

  void handleFailure(Function retry, response) {
    switch (response.code) {
      case -1:
        showNetworkError(retry);
        break;
      case 401:
        showNeedLogin();
        break;
      default:
        showNetworkError(retry, message: response.message);
    }
    debugPrint("$this fetched ${response.message} ${response.code}");
  }
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

  Widget buildErrorState(VM viewModel, BuildContext context) => Container(
        child: Center(
          child: UULErrorMessage(
            message: viewModel.viewState.error.message,
            onRetryTap: viewModel.viewState.error.retry,
            onCancelTap: viewModel.viewState.error.cancel ?? _getDefaultCancelAction(viewModel),
            canCancel: viewModel.viewState.error.canCancel,
          ),
        ),
      );

  Widget buildErrorStateWithContent(VM viewModel, BuildContext context) {
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
        body = viewModel.viewState.value == null
            ? buildErrorState(viewModel, context)
            : UULOverlayErrorMessage(
                buildIdleState(viewModel, context),
                message: viewModel.viewState.error.message,
                onRetryTap: viewModel.viewState.error.retry,
                onCancelTap: viewModel.viewState.error.cancel ?? _getDefaultCancelAction(viewModel),
                canCancel: viewModel.viewState.error.canCancel,
              );
        break;
      case ViewStatus.LOADING:
        body = viewModel.viewState.value == null ? buildLoadingState(viewModel, context) : UULOverlayLoadingIndicator(child: buildIdleState(viewModel, context));
        break;
    }
    return body;
  }

  Function _getDefaultCancelAction(VM viewModel) {
    return () {
      viewModel.viewState = viewModel.viewState.copyWith(status: ViewStatus.IDLE, error: null);
      viewModel.notifyAll();
    };
  }
}
