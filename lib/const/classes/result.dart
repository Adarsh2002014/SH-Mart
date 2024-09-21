import 'package:shmart/shmart.dart';

class Result {

  ApiResult status = ApiResult.failure;
  String message = "NA";
  dynamic data;

  Result({required this.status, required this.message, required this.data});
}
