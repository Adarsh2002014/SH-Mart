import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderItems extends StatefulWidget {
  var p, dbobj;

  OrderItems({super.key, this.p, this.dbobj});

  @override
  State<OrderItems> createState() => _OrderItemsState();
}

class _OrderItemsState extends State<OrderItems> {
  var p, db, login = null;
  TextEditingController orderItemName = TextEditingController();
  TextEditingController orderItemQuantity = TextEditingController();
  TextEditingController validationKey = TextEditingController();
  TextEditingController validationPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    p = widget.p;
    db = widget.dbobj;
    if (p.getString("login") != null) {
      login = true;
    } else {
      login = false;
    }
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
          actions: [
            IconButton(
                icon: const Icon(Icons.lock_rounded, color: Colors.white),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("Login"),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Validation Key',
                                    ),
                                    controller: validationKey,
                                  ),
                                ]),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: "Dashiki", fontSize: 20),
                                ),
                                onPressed: () {
                                  p.setString("login", validationKey.text);
                                  Navigator.pop(context);
                                  setState(() {
                                    validationKey.clear();
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontFamily: "Dashiki", fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]);
                      });
                }),
            IconButton(
                icon: const Icon(Icons.key_rounded, color: Colors.white),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            title: const Text("Password Validation Key"),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Validation Key',
                                    ),
                                    controller: validationPassword,
                                  ),
                                ]),
                            actions: [
                              TextButton(
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      fontFamily: "Dashiki", fontSize: 20),
                                ),
                                onPressed: () {
                                  p.setString(
                                      "password", validationPassword.text);
                                  Navigator.pop(context);
                                  setState(() {
                                    validationPassword.clear();
                                  });
                                },
                              ),
                              TextButton(
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontFamily: "Dashiki", fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ]);
                      });
                }),
            IconButton(
                icon: const Icon(Icons.add_rounded, color: Colors.white),
                onPressed: () {
                  print(p.getString("login"));
                  db
                      .collection("validationKey")
                      .where("key", isEqualTo: p.getString("login"))
                      .get()
                      .then((value) {
                    if (value.docs.length == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Needed to login with latest Password"),
                      ));
                      return;
                    }
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: const Text("Add Item"),
                              content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Enter Item Name',
                                      ),
                                      controller: orderItemName,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText:
                                          'Enter Quantity Description',
                                        ),
                                        controller: orderItemQuantity,
                                      ),
                                    ),
                                  ]),
                              actions: [
                                TextButton(
                                  child: const Text(
                                    "Add",
                                    style: TextStyle(
                                        fontFamily: "Dashiki", fontSize: 20),
                                  ),
                                  onPressed: () {
                                    storeDataToDB();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontFamily: "Dashiki", fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ]);
                        });
                  });
                })
          ],
        ),
        body: FutureBuilder(
            future: db.collection("itemNames").get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot =
                snapshot.data as QuerySnapshot<Object?>;
                List<DocumentSnapshot> documents = querySnapshot.docs;
                return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 12, right: 12, bottom: 8),
                        child: Card(
                          child: ListTile(
                            title: Text(
                              documents[index]["orderItem"],
                              style: const TextStyle(
                                  fontFamily: "Dashiki",
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(
                              documents[index]["orderQuantity"],
                              style: TextStyle(
                                  fontFamily: "Dashiki",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text("Delete Item"),
                                        content: const Text(
                                            "Are you sure you want to delete this item?"),
                                        actions: [
                                          TextButton(
                                            child: const Text("Yes"),
                                            onPressed: () async {
                                              print(p.getString("password"));
                                              db
                                                  .collection("validationKey")
                                                  .where("deleteKey",
                                                  isEqualTo: p.getString(
                                                      "password"))
                                                  .get()
                                                  .then((value) {
                                                if (value.docs.length == 0) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "Needed to login with latest Password"),
                                                  ));
                                                  return;
                                                } else {
                                                  db
                                                      .collection("itemNames")
                                                      .doc(documents[index].id)
                                                      .delete();
                                                  setState(() {});
                                                  Navigator.pop(context);
                                                }
                                              });
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("No"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                        ),
                      );
                    });
                // for (DocumentSnapshot document in documents) {
                //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                //   print(data["orderItem"]);
                //   // String itemName = data['name']; // Access specific fields
                //   // ... (process other fields)
                // }
                // return Container();
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error Occured"),
                );
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  void storeDataToDB() async {
    if (orderItemName.text.isEmpty || orderItemQuantity.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please fill all the fields"),
      ));
      return;
    }
    var obj = {
      "orderItem": orderItemName.text,
      "orderQuantity": orderItemQuantity.text,
    };
    print(db);
    try {
      await db.collection("itemNames").add(obj).then((value) => print(value));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Item Added Successfully"),
      ));
      setState(() {});
      orderItemName.clear();
      orderItemQuantity.clear();
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error Occured"),
      ));
      print(e);
    }
  }
}
