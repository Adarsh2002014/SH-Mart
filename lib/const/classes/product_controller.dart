import 'package:shmart/shmart.dart';
import 'package:dio/dio.dart' as http;

class ProductController extends GetxController {
  RxList quickItem = <Item>[].obs;
  RxList storedItem = <Item>[].obs;

  Future<Result> getItems(
      {String itemName = "",
      String barcode = "",
      required BuildContext context}) async {
    Result response =
        Result(status: ApiResult.failure, message: "NA", data: {});
    try {
      late String url;
      final dio = http.Dio();
      // final ipAddress = SharedPreferenceHelper().getString("ipAddress");
      const ipAddress = "192.168.0.104";
      if (ipAddress != "") {
        if (itemName != "" || barcode != "") {
          showNonDismisableDialog(context);
          url =
              "http://$ipAddress:9898/api/item/list?filter_barcode_value=${barcode}&filter_name=${itemName}&start_index=1&record_count=7000&get_total_count=1&accountee_identifier=8866268666&accountee_id=1";
          print(url);
          dio.options.receiveTimeout = const Duration(seconds: 30);
          dio.options.connectTimeout = const Duration(seconds: 30);
          http.Response resp = await dio.get(url);
          print(resp.data);
          if (resp.statusCode == 200) {
            var data = jsonDecode(resp.data);
            for (var item in data["records"]) {
              print(item);
              storedItem.add(Item.fromJson(item));
            }
            response = Result(
                status: ApiResult.success,
                message: "Data Fetched",data: {});
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Enter Barcode or Name",
                style: TextStyle(fontFamily: "Dashiki")),
          ));
          return response;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("IP Address not set",
              style: TextStyle(fontFamily: "Dashiki")),
        ));
      }
    } catch (e) {
      if (kDebugMode) {
        print("\n\n");
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Found Error",
              style: TextStyle(fontFamily: "Dashiki")),
        ));
        print(e);
      }
    }
    Navigator.pop(context);
    return response;
  }

  Future<Result> getAllItems({required BuildContext context}) async {
    Result response =
        Result(status: ApiResult.failure, message: "NA", data: {});
    try {
      late String url;
      final dio = http.Dio();
      final ipAddress = SharedPreferenceHelper().getString("ipAddress");
      if (ipAddress != "") {
        url =
            "http://$ipAddress:9898/api/item/list?filter_barcode_value=&filter_name=&start_index=1&record_count=7000&get_total_count=1&accountee_identifier=8866268666&accountee_id=1";
        http.Response resp = await dio.get(url);
        if (resp.statusCode == 200) {
          for (var item in resp.data['records']) {
            storedItem.add(Item.fromJson(item));
          }
          response = Result(
              status: ApiResult.success,
              message: "Data Fetched",
              data: resp.data);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Enter Barcode or Name",
                style: TextStyle(fontFamily: "Dashiki")),
          ));
          return response;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("IP Address not set",
              style: TextStyle(fontFamily: "Dashiki")),
        ));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return response;
  }
}
