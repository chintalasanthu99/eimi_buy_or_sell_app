import 'package:Eimi/vendor/models/Product.dart';

class BookingModel {
  final String id;
  final String customer;
  final String status;
  final DateTime date;
  final ProductModel product;

  BookingModel({
    required this.id,
    required this.customer,
    required this.status,
    required this.date,
    required this.product,
  });
}
