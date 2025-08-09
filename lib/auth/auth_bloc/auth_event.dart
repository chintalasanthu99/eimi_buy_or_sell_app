import 'package:eimi_buy_or_sell_app/auth/modles/login_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class BaseEvent extends Equatable {}

class LogInEvent extends BaseEvent {
  final LogInRequest request;

  LogInEvent(this.request);

  @override
  List<Object> get props => [request];
}

class VendorLogInEvent extends BaseEvent {
  final LogInRequest request;

  VendorLogInEvent(this.request);

  @override
  List<Object> get props => [request];
}