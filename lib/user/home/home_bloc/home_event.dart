import 'package:eimi_buy_or_sell_app/user/home/models/category_filter_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class BaseEvent extends Equatable {}

class CategoryFilterEvent extends BaseEvent {
  final CategoryFilterRequest request;

  CategoryFilterEvent(this.request);

  @override
  List<Object> get props => [request];
}