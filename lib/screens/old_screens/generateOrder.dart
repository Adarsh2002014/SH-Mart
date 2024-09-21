import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class GenerateOrder extends StatefulWidget {
  late var p;

  GenerateOrder({super.key, this.p});

  @override
  State<GenerateOrder> createState() => _GenerateOrderState();
}

class _GenerateOrderState extends State<GenerateOrder> {
  var dio = Dio();
  var floatingButtonColor = const Color(0xfff89e76);
  late SharedPreferences prefs;
  List<String> autoItem = [], selectedItem = [];
  TextEditingController itemController = TextEditingController();

  @override
  void initState() {
    super.initState();
    prefs = widget.p;
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
          "   Create Order List",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
              fontFamily: "Dashiki",
              color: Colors.white),
        ),
        backgroundColor: const Color(0xffff7a40),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () {
              shareItems();
            },
            icon: const Icon(Icons.share_rounded, color: Colors.white)
          ),
        ],
      ),
      body: selectedItem.isEmpty
          ? const Center(
              child: Text(
                "Create Order List!!!!",
                style: TextStyle(fontFamily: "Dashiki"),
              ),
            )
          : listView(),
      floatingActionButton: addItemToOrderList(),
    );
  }

  storeItemsData() async {
    if(autoItem.isNotEmpty){
      return;
    }
    var ipAddress = await prefs.getString("ip");
    var url =
        "http://$ipAddress:9898/api/item/list?filter_barcode_value=&filter_name=&start_index=1&record_count=7000&get_total_count=1&accountee_identifier=8866268666&accountee_id=1";
    var response = await dio.get(url);
    var jsonData = jsonDecode(response.data);
    var data = jsonData['records'];
    for (var item in data) {
      autoItem.add(item['name']);
    }
    print("Auto Item is stored here ---------------------------------");
    print(autoItem);
    floatingButtonColor = const Color(0xffff7a40);
  }

  Widget listView() {
    return ListView.builder(
      itemCount: selectedItem.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            title: Text(selectedItem[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete_rounded),
              onPressed: () {
                setState(() {
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("Delete Item"),
                      content: const Text("Are you sure you want to delete this item?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              selectedItem.removeAt(index);
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Delete"),
                        ),
                      ],
                    );
                  });
                });
              },
            ),
          ),
        );
      },
    );
  }

  addItemToOrderList() {
    return FutureBuilder(
      future: storeItemsData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return FloatingActionButton(
            onPressed: () {},
            backgroundColor: floatingButtonColor,
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: CircularProgressIndicator(backgroundColor: Color(0xffff7a40),color: Colors.white,),
            ),
          );
        }
        return FloatingActionButton(
          onPressed: () {
            floatingButtonAction();
          },
          backgroundColor: floatingButtonColor,
          child: const Icon(Icons.add_rounded, color: Colors.white,size: 34,),
        );
      },
    );
  }

  floatingButtonAction() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Item"),
          content: Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return autoItem.where((option) {
                return option
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              setState(() {

                print(selection);
              });
            },
            fieldViewBuilder:
                (context, controller, focusNode, onEditingComplete) {
              itemController = controller;
              print("-------------AutoCompelete Brand is called");
              return TextFormField(
                controller: itemController,
                focusNode: focusNode,
                onEditingComplete: onEditingComplete,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Brand Name',
                    suffixIcon: IconButton(
                        onPressed: () {
                          itemController.text = "";
                        },
                        icon: const Icon(Icons.clear))),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                if(itemController.text != ""){
                  print(itemController.text);
                  setState(() {
                    selectedItem.add(itemController.text);
                  });
                }
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  shareItems(){
    var data = "Date:- ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}\n\n-----------------";
    for(var item in selectedItem) {
      data += "$item\n";
    }
    data += "-----------------";
    Share.share(data);
  }
}
