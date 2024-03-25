import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:shmart/expiryItemsPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExpiryPage extends StatefulWidget {
  var dbobj, p;
  ExpiryPage({super.key, required this.dbobj, required this.p});

  @override
  State<ExpiryPage> createState() => _ExpiryPageState();
}

class _ExpiryPageState extends State<ExpiryPage> {
  final dio = Dio();
  var db, p;
  List<String> autobrand = [], autoitem = [];
  Map<String,List<String>> items= {};
  TextEditingController brandController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    db = widget.dbobj;
    p = widget.p;
    storeItemsData();
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
          'Expiry List',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
              color: Colors.white,
              fontFamily: "Dashiki"
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xffff7a40),
        actions: [
          IconButton(
              onPressed: () {
                addItem();
              },
              icon: const Icon(Icons.add_rounded)
          )
        ],
      ),
      body: FutureBuilder(
          future: db.collection("expiryItems").get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot querySnapshot =
              snapshot.data as QuerySnapshot<Object?>;
              List<DocumentSnapshot> documents = querySnapshot.docs;
              if(documents.length==0){
                return const Center(
                  child: Text("No Expiry Items",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: "Dashiki"),),
                );
              }
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    var doc = documents[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 12, right: 12, bottom: 8
                      ),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExpiryItemPage(
                                    dbobj: db,
                                    brandName: doc.id,
                                  )
                              )
                          ).then((value) => {setState(() {})});
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(
                              doc.id,
                              style: const TextStyle(
                                  fontFamily: "Dashiki",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.keyboard_arrow_right_rounded),
                              onPressed: (){},
                            ),
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error Occured"),
              );
            }
            return const Center(child: CircularProgressIndicator());
          })
    );
  }

  addItem(){
    showDialog(context: context, builder: (context){
      bool testBool = true;
      return AlertDialog(
        title: const Text("Add Expiry Item"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return autobrand.where((option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    selectedBrand(selection);
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    brandController = controller;
                    print("-------------AutoCompelete Brand is called");
                    return TextFormField(
                      controller: brandController,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Brand Name',
                          suffixIcon: IconButton(
                              onPressed: () {
                                brandController.text = "";
                              },
                              icon: const Icon(Icons.clear))),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return autoitem.where((option) {
                      return option
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  onSelected: (String selection) {
                    selectedItem(selection);
                  },
                  fieldViewBuilder:
                      (context, controller, focusNode, onEditingComplete) {
                    itemController = controller;
                    return TextFormField(
                      controller: itemController,
                      focusNode: focusNode,
                      onEditingComplete: onEditingComplete,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Item Name',
                          suffixIcon: IconButton(
                              onPressed: () {
                                itemController.text = "";
                              },
                              icon: const Icon(Icons.clear))),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: expiryDateController,
                  readOnly: true, // to prevent the opening of the keyboard
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Expiry Date',
                      suffixIcon: IconButton(
                          onPressed: () {
                            expiryDateController.clear();
                          },
                          icon: const Icon(Icons.clear)
                      )
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      expiryDateController.text = formattedDate;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: quantityController,
                  keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Quantity',
                        suffixIcon: IconButton(
                            onPressed: () {
                              itemController.text = "";
                            },
                            icon: const Icon(Icons.clear)
                        )
                    )
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("Cancel")),
          TextButton(onPressed: (){
            // Add item to database
            insertDataToDatabase();
          }, child: const Text("Add")),
        ],
      );
    });
  }

  storeItemsData() async {
    print("Storing Items Data Method is Called");
    var ipAddress = await p.getString("ip");
    var url =
    "http://$ipAddress:9898/api/item/list?filter_barcode_value=&filter_name=&start_index=1&record_count=5000&get_total_count=1&accountee_identifier=8866268666&accountee_id=1";
    print(url);
    var response = await dio.get(url);
    var jsonData = jsonDecode(response.data);
    var data = jsonData['records'];
    for(var item in data){
      if(!items.containsKey(item['brand_name'])){
        items[item['brand_name']] = [];
        autobrand.add(item['brand_name']);
      }
      var list = items[item['brand_name']];
      list?.add(item['name']);
      autoitem.add(item['name']);
      items[item['brand_name']] = list!;
    }
    print(autobrand);
    print(autoitem);
  }

  selectedBrand(value){
    autoitem = items[value]!;
    itemController.text = "";
    setState(() {});
  }

  selectedItem(value){
    setState(() {
    print("selected Item is called");
    // selectedItemValue = value;
    var result = items.entries.firstWhere((entry) => entry.value.contains(value), orElse: () => const MapEntry("", []));
    print(result);
    brandController.text = result.key;
    autoitem = items[result.key]!;}
    );
  }

  insertDataToDatabase(){
    var brandName = brandController.text;
    var itemName = itemController.text;
    var expiryDate = expiryDateController.text;
    var quantity = quantityController.text;
    if(brandName.isEmpty || itemName.isEmpty || expiryDate.isEmpty || quantity.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("All Fields are Mandatory"),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    db.collection("expiryItems").doc(brandName).set({
      itemName: [expiryDate, quantity],
      // "expiryDate": expiryDate,
      // "quantity": quantity
    },SetOptions(merge: true)).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Item Added Successfully"),
          duration: Duration(seconds: 2),
        ),
      );
      setState(() {
        brandController.clear();
        itemController.clear();
        expiryDateController.clear();
        quantityController.clear();
      });
      Navigator.pop(context);
    }).catchError((error){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error Occured"),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }
}
