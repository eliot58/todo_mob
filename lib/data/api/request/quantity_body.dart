import 'package:dio/dio.dart';

class CreateQuantityBody {
  final int shape;
  final int implement;
  final int order;
  final String date;
  final int price;
  final String comment;
  final MultipartFile file;

  CreateQuantityBody({required this.shape, required this.implement,required this.order, required this.price, required this.comment, required this.file, required this.date});

  FormData toApi() {
    return FormData.fromMap({"shape": shape, "implement": implement, "order" : order, "price": price, "comment": comment, "file": file, "date": date});
  }
}
