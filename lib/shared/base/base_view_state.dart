import 'package:flutter/material.dart';
import 'package:shopping_app/shared/base/base_view_model.dart';

abstract class BaseViewState<T extends StatefulWidget, M extends BaseViewModel> extends State<T> with AutomaticKeepAliveClientMixin<T> {
  M _viewModel;

  M get viewModel => _viewModel;

  @override
  bool get wantKeepAlive => true;

  @protected
  void loadArguments() {}

  @protected
  M createViewModel();

  @override
  void initState() {
    _viewModel = createViewModel();
    if (_viewModel == null) {
      throw Exception("View Model $M must be initialized");
    }

    super.initState();
    loadArguments();
    _viewModel.initState();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    loadArguments();
  }

  @override
  void dispose() {
    _viewModel.disposeState();
    super.dispose();
  }
}
