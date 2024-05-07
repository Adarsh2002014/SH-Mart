import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shmart/helper/loadingAnimation.dart';

// ignore: must_be_immutable
class BarcodeSticker extends StatefulWidget {
  var db, p;
  BarcodeSticker({super.key, this.db, this.p});

  @override
  State<BarcodeSticker> createState() => _BarcodeStickerState();
}

class _BarcodeStickerState extends State<BarcodeSticker> with SingleTickerProviderStateMixin{
  var db, autoCompleteList, selectedName, url, prefs, itemList = {};
  final dio = Dio();
  TextEditingController itemValue = TextEditingController();
  @override
  void initState() {
    prefs = widget.p;
    super.initState();
    db = widget.db;
  }

  callApi() async {
    var ipAddress = await prefs.getString("ip");
    url =
    "http://$ipAddress:9898/api/item/list?filter_barcode_value=&filter_name=&start_index=1&record_count=5000&get_total_count=1&accountee_identifier=8866268666&accountee_id=1";
    print(url);
    var data;
    try{data = await dio.get(url,options: Options(receiveTimeout: const Duration(seconds: 30)));}catch(e){data = "Error";}
    return data;
  }

  @override
  Widget build(BuildContext context) {
    print(Theme.of(context).brightness);
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
          iconTheme: IconThemeData(color: Colors.white),
          actions: const [
          ]),
      body: Container(
        child: FutureBuilder(
            future: callApi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(snapshot.data == "Error"){
                  return const Center(
                    child: Text("Error Fetching Data, Revisit the page"),
                  );
                }
                // DocumentSnapshot querySnapshot =
                //     snapshot.data as DocumentSnapshot<Object?>;
                // autoCompleteList = querySnapshot.get("list");
                // List<String> list = autoCompleteList.cast<String>();
                var data = {};
                data = jsonDecode(snapshot.data.toString());
                List<String> names = [];
                autoCompleteList = data["records"];
                for (var i = 0; i < data["records"].length; i++) {
                  names.add(data["records"][i]["name"]);
                }
                data = {};
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 8.0),
                    child: Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return names.where((option) {
                          return option
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        selectedName = selection;
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onEditingComplete) {
                        return TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Item Name',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.clear();
                                  },
                                  icon: const Icon(Icons.clear))),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
                    child: TextField(
                      controller: itemValue,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'No of Stickers',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            itemValue.clear();
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          uploadData();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffff7a40)),
                        ),
                        child: const Text(
                          "Add Barcode",
                          style: TextStyle(
                              fontFamily: 'Dashiki',
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              fontSize: 20),
                        )),
                  ),
                  returnBody()
                ]);
              } else {
                return const Center(
                  child: LoadingAnimation()
                );
              }
            }),
      ),
    );
  }

  Widget returnBody() {
    // print(itemList);
    return FutureBuilder(
        future: db.collection("barCodes").doc("pendingBarcode").get(),
        builder: (context, snapshot) {
          DocumentSnapshot documentSnapshot =
          snapshot.data as DocumentSnapshot<Map<dynamic, dynamic>>;
          print(documentSnapshot.data());
          itemList = documentSnapshot.data() as Map<dynamic, dynamic>;
          if (itemList.isNotEmpty) {
            return Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color(0xffff7a40),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                "${itemList.keys.elementAt(index)}",
                                style: const TextStyle(
                                    fontSize: 23,
                                    fontFamily: 'Dashiki',
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25.0),
                                  child: Text(
                                    "Amt:- ${itemList.values.elementAt(index)[1]}",
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Dashiki',
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: Colors.white,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete_rounded,
                                      color: Color(0xffff7a40),
                                      size: 26,
                                    ),
                                    onPressed: () {
                                      removeItemValue(index);
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("No Pending Barcodes"),
            );
          }
        });
  }

  uploadData() {
    if (selectedName == "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please select an item"),
      ));
    } else {
      bool flag = false;
      List<dynamic> list = autoCompleteList;
      for (var i = 0; i < itemList.length; i++) {
        if (itemList[i] == selectedName) {
          print("Value ${list[i]} is present in list");
          flag = true;
          break;
        }
      }
      if (flag) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Item already exists"),
        ));
      } else {
        Map<Object, Object?> data = itemList as Map<Object, Object?>;
        var barcodeValue, salePrice, mrp;
        for(int i=0;i<autoCompleteList.length;i++){
          if(autoCompleteList[i]["name"] == selectedName){
            barcodeValue = autoCompleteList[i]["barcode_value"];
            salePrice = autoCompleteList[i]["price_sale"];
            mrp = autoCompleteList[i]["price_mrp"];
            break;
          }
        }
        data[selectedName] = [barcodeValue, itemValue.text, salePrice, mrp];
        db
            .collection('barCodes')
            .doc("pendingBarcode")
            .update(data)
            .then((value) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Item added successfully"),
          ));
          setState(() {});
        }).catchError((e) => {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Error adding item"),
          ))
        });
      }
    }
  }

  removeItemValue(index) async {
    print(index);
    print(itemList.keys.elementAt(index));
    itemList.remove(itemList.keys.elementAt(index));
    print(itemList);
    try {
      await db
          .collection("barCodes")
          .doc("pendingBarcode")
          .set(itemList)
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Item removed successfully"),
        ));
        print("Data Updated");
        setState(() {});
      });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error removing item"),
      ));
    }
  }
}
