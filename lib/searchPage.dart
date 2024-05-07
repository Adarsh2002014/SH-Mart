import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:dio/dio.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  var p;

  SearchPage({super.key, this.p});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var prefs;
  late Map<String, dynamic> response;
  FocusNode fn1 = new FocusNode();
  FocusNode fn2 = new FocusNode();
  String barcode = "";
  String ipAddress = "";
  TextEditingController itemValue = TextEditingController();
  TextEditingController barcodeValue = TextEditingController();

  @override
  initState() {
    super.initState();
    prefs = widget.p;
    if (prefs == null) {
      return;
    }
    ipAddress = prefs.getString('ip') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          title: const Text(
            'ShMart',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Colors.white,
                fontFamily: "Dashiki"),
          ),
          backgroundColor: const Color(0xffff7a40),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_tree_sharp, color: Colors.white),
              onPressed: () {
                showIPModal();
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
          child: Column(
            children: [
              TextFormField(
                focusNode: fn1,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter Barcode',
                    suffixIcon: IconButton(
                        onPressed: () {
                          barcodeValue.clear();
                        },
                        icon: Icon(Icons.clear))),
                controller: barcodeValue,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: TextFormField(
                  focusNode: fn2,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Enter Name',
                    suffixIcon: IconButton(
                        onPressed: () {
                          itemValue.clear();
                        },
                        icon: Icon(Icons.clear)),
                  ),
                  controller: itemValue,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    searchItem();
                    setState(() {});
                  },
                  icon: const Icon(Icons.search, color: Colors.white),
                  label: const Text(
                    "Search Item",
                    style:
                    TextStyle(fontFamily: "Dashiki", color: Colors.white),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(12)),
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xffff7a40)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8),
                width: double.infinity,
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            // await Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => AiBarcodeScanner(
                            //       canPop: false,
                            //       controller: MobileScannerController(
                            //           detectionSpeed: DetectionSpeed.noDuplicates),
                            //       onScan: (String value) {
                            //       //   print(value);
                            //         if (context.mounted) {
                            //           Navigator.of(context).pop();
                            //           setState(() {});
                            //         }
                            //         barcode = value;
                            //         barcodeValue.text = barcode;
                            //       },
                            //     ),
                            //   ),
                            // );
                            barcodeValue.text = await FlutterBarcodeScanner.scanBarcode(
                                "#ff6666",
                                "Return",
                                false,
                                ScanMode.BARCODE);
                            if(barcodeValue.text.isNotEmpty){
                              searchItem();
                            }
                            searchItem() ;
                          } catch (e) {
                            print(e);
                          }
                        },
                        label: const Text("Barcode",
                            style: TextStyle(
                                fontFamily: "Dashiki", color: Colors.white)),
                        icon: const Icon(FontAwesomeIcons.barcode, color: Colors.white),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(12)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffff7a40)),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                              const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              futureBuilder()
            ],
          ),
        ));
  }

  searchItem() async {
    fn1.unfocus();
    fn2.unfocus();
    String url;
    final dio = Dio();
    if (ipAddress != "") {
      if (itemValue.text != "" || barcodeValue.text != "") {
        url =
        "http://$ipAddress:9898/api/item/list?filter_barcode_value=${barcodeValue.text}&filter_name=${itemValue.text}&start_index=1&record_count=5000&get_total_count=1&accountee_identifier=8866268666&accountee_id=1";
        // print(url);
        var resp = await dio.get(url);
        response = jsonDecode(resp.toString());
        return response;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Enter Barcode or Name",
              style: TextStyle(fontFamily: "Dashiki")),
        ));
        return;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
        Text("IP Address not set", style: TextStyle(fontFamily: "Dashiki")),
      ));
      return;
    }
  }

  showIPModal() {
    TextEditingController ipValue = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Enter Configuaration"),
            content: TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Configuration',
              ),
              controller: ipValue,
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await prefs.setString('ip', ipValue.text);
                  ipAddress = ipValue.text;
                  Navigator.of(context).pop();
                },
                child: const Text("Save"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"))
            ],
          );
        });
  }

  Widget futureBuilder() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(response);
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ListView.builder(
                itemCount: response["records"].length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 12.0, right: 12.0, bottom: 10.0),
                        child: Column(children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              response["records"][index]["name"],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: "Dashiki"),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "SH Price: ${response["records"][index]["price_sale"]}",
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xffff7a40),
                                  fontFamily: "Dashiki"),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "MRP: ${response["records"][index]["price_mrp"]}",
                              style: const TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green,
                                  fontFamily: "Dashiki"),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Stock: ${response["records"][index]["stock_available"]}",
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: "Dashiki"),
                            ),
                          )
                        ]),
                      ));
                },
              ),
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.only(top: 12),
            child: const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Dashiki"),
              ),
            ),
          );
        }
      },
      future: searchItem(),
    );
  }
}
