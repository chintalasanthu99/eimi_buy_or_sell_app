import 'package:equatable/equatable.dart';

class BaseState extends Equatable {
  //abstract
  @override
  List<Object> get props => [];
}

class Init extends BaseState {
  @override
  String toString() => 'Init';
}
class LoadingDisable extends BaseState {
  @override
  String toString() => 'LoadingDisable';
}
class Loading extends BaseState {
  @override
  String toString() => 'Loading';
}
class SilentLoading extends BaseState {
  @override
  String toString() => 'SilentLoading';
}

class DataLoaded<T> extends BaseState {
  T? data;
  String? event;

  DataLoaded({this.data, this.event});

  @override
  String toString() => 'DataLoaded';
}

class BaseError extends BaseState {
  final String errorMessage;

  BaseError(this.errorMessage);

  @override
  String toString() => 'Error';

  @override
  List<Object> get props => [errorMessage];
}

class ScreenError extends BaseState {
  final int errorId;
  final String errorMessage;

  ScreenError(this.errorId,this.errorMessage);

  @override
  String toString() => 'Error';

  @override
  List<Object> get props => [errorId,errorMessage];
}
