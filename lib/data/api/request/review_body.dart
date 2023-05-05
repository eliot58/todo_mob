import 'package:dio/dio.dart';

class CreateReviewBody {
  final int to;
  final int productQuality;
  final int deliveryQuality;
  final int supplierLoyalty;

  CreateReviewBody({required this.to, required this.productQuality, required this.deliveryQuality, required this.supplierLoyalty});

  FormData toApi() {
    return FormData.fromMap({});
  }
}
