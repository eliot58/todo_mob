import 'package:dio/dio.dart';

class CreateOrderBody {
  final int shape;
  final int implement;
  final String typePay;
  final String typeDelivery;
  final int amountwindow;
  final String address;
  final int price;
  final String comment;
  final List<MultipartFile> files;

  CreateOrderBody({required this.shape, required this.implement,required this.address, required this.typePay, required this.typeDelivery, required this.amountwindow, required this.price, required this.comment, required this.files});

  FormData toApi() {
    return FormData.fromMap({"shape": shape, "implement": implement, "address":  address, "type_pay": typePay, "type_delivery": typeDelivery, "amount_window": amountwindow, "price": price, "comment": comment, "files": files});
  }
}
