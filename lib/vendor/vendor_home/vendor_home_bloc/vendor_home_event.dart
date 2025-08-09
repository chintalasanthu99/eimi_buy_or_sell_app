import 'package:eimi_buy_or_sell_app/user/home/models/category_filter_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class VendorHomeEvent extends Equatable {}

class VendorStatsEvent extends VendorHomeEvent {
  final String request;

  VendorStatsEvent(this.request);

  @override
  List<Object> get props => [request];
}