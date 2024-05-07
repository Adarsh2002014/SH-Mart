import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shmart/helper/loadingAnimation.dart';

class ExpiryItemPage extends StatefulWidget {
  var dbobj, brandName;

  ExpiryItemPage({super.key, required this.dbobj, required this.brandName});

  @override
  State<ExpiryItemPage> createState() => _ExpiryItemPageState();
}

class _ExpiryItemPageState extends State<ExpiryItemPage> {
  var db, data;
  String brandName = "";

  @override
  void initState() {
    super.initState();
    db = widget.dbobj;
    brandName = widget.brandName;
    print(brandName);
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
            'Expired Item Data',
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 26,
                color: Colors.white,
                fontFamily: "Dashiki"),
          ),
          actions: [
            IconButton(
              onPressed: () {
                shareExpiredItems();
              },
              icon: const Icon(Icons.share_rounded),
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xffff7a40),
        ),
        body: FutureBuilder(
          future: db.collection('expiryItems').doc(brandName).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingAnimation(),
              );
            }
            DocumentSnapshot documentSnapshot =
                snapshot.data as DocumentSnapshot;
            Map<String, dynamic> val =
                documentSnapshot.data() as Map<String, dynamic>;
            data = val;
            print(val.keys);
            return ListView.builder(
              itemCount: val.keys.length,
              itemBuilder: (context, index) {
                var key = val.keys.elementAt(index);
                var value = val[key];
                return Card(
                  child: ListTile(
                      title: Text(key),
                      subtitle: Text(
                          "Expiry Date: ${value[0]}  Quantity: ${value[1]}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Delete Item"),
                                content: const Text(
                                    "Are you sure you want to delete this item?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (val.keys.length <= 1) {
                                        print("First Function is called");
                                        db
                                            .collection('expiryItems')
                                            .doc(brandName)
                                            .delete();
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      } else {
                                        print("Second Function is called");
                                        print(val.keys.length);
                                        db
                                            .collection('expiryItems')
                                            .doc(brandName)
                                            .update({key: FieldValue.delete()});
                                        Navigator.of(context).pop();
                                        setState(() {});
                                      }
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            },
                          );
                          // db.collection('expiryItems').doc(brandName).update({
                          //   key: FieldValue.delete()
                          // });
                          // setState(() {});
                        },
                      )),
                );
              },
            );
          },
        ));
  }

  shareExpiredItems() {
    if (data == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("No Data"),
              content: const Text("No data is set to share, wait for some time to get data/ set data"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Ok"),
                ),
              ],
            );
          }
       );
      return;
    }
    String dataToShare = "-----Expired Items-----\n\n";
    for (var key in data.keys) {
      dataToShare += "Product Name: $key\nProduct Expiry Date: ${data[key][0]}\nProduct Expiry Count: ${data[key][1]}\n\n";
    }
    Share.share(dataToShare);
  }
}
