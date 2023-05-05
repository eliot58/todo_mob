import 'package:dio/dio.dart';

class CreateQuantityBody {
  final int shape;
  final int implement;
  final String date;
  final int price;
  final String comment;
  final List<MultipartFile> files;

  CreateQuantityBody({required this.shape, required this.implement, required this.price, required this.comment, required this.files, required this.date});

  FormData toApi() {
    return FormData.fromMap({});
  }
}
