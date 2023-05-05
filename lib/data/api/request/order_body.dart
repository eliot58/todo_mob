import 'package:dio/dio.dart';

class CreateOrderBody {
  final int shape;
  final int implement;
  final String typePay;
  final String typeDelivery;
  final int amountwindow;
  final int price;
  final String comment;
  final List<MultipartFile> files;

  CreateOrderBody({required this.shape, required this.implement, required this.typePay, required this.typeDelivery, required this.amountwindow, required this.price, required this.comment, required this.files});

  FormData toApi() {
    return FormData.fromMap({});
  }
}
