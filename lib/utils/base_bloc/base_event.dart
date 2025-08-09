
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


@immutable
abstract class BaseEvent extends Equatable {}

class BaseApiCall extends BaseEvent {
  final String request;

  BaseApiCall(this.request);

  @override
  List<Object> get props => [request];
}



