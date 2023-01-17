import 'dart:async';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  final StreamController _inputStateStreamController = StreamController();

  @override
  Sink get inputState => _inputStateStreamController.sink;

  @override
  Stream get outputState =>
      _inputStateStreamController.stream.map((flowState) => flowState);

  @override
  void dispose() {
    _inputStateStreamController.close();
  }

// shared variables and functions that will be used through any view model.
}

abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called when view model dies.

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream get outputState;
}
