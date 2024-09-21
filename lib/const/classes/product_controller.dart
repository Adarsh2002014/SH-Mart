import 'package:shmart/shmart.dart';

class ProductController extends GetxController {
  RxList item = <Item>[].obs;

  Result getItems({String itemName = "", String barcode = ""}) {
    Result response =
        Result(status: ApiResult.failure, message: "NA", data: {});
    try {
      // Here goes logic for calling the api to get list of items.
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return response;
  }

  Result getAllItems({String itemName = "", String barcode = ""}) {
    Result response =
        Result(status: ApiResult.failure, message: "NA", data: {});
    try {
      // Here goes logic for calling the api to get list of all items.
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return response;
  }
}
