import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Receivables extends StatefulWidget {
  final dbobj;
  const Receivables({super.key, this.dbobj});

  @override
  State<Receivables> createState() => _ReceivablesState();
}

class _ReceivablesState extends State<Receivables> {
  var db, data;
  TextEditingController name = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController lender = TextEditingController();
  TextEditingController date = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = widget.dbobj;
    date.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
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
                icon: const Icon(Icons.add_rounded, color: Colors.white),
                onPressed: () async {
                  _addReceivables(context);
                })
          ],
        ),
        body: FutureBuilder(
            future: db.collection("receivables").orderBy('name').get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot =
                    snapshot.data as QuerySnapshot<Object?>;
                List<DocumentSnapshot> documents = querySnapshot.docs;
                print(documents);
                if (documents.isEmpty) {
                  return const Center(
                    child: Text('There is no receivables'),
                  );
                }
                return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 12, right: 12, bottom: 8),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                'Name: ${documents[index]["name"]}',
                                style: const TextStyle(
                                    fontFamily: "Dashiki",
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Amount: ${documents[index]["amount"]}',
                                    style: const TextStyle(
                                        fontFamily: "Dashiki",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 2,),
                                  Text(
                                    'Lender: ${documents[index]["lender"]}',
                                    style: const TextStyle(
                                        fontFamily: "Dashiki",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Date: ${documents[index]["date"]}',
                                    style: const TextStyle(
                                        fontFamily: "Dashiki",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _sumReceivables(documents, index),
                                  _deleteReceivables(documents, index)
                                ],
                              ),
                            ),
                          ));
                    });
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("Error Occured"),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }

  Future<dynamic> _addReceivables(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text("Add Entry"),
              content: Column(mainAxisSize: MainAxisSize.min, children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Person Name',
                  ),
                  controller: name,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Receivables',
                    ),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                    controller: amount,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Lender Name',
                    ),
                    controller: lender,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child:TextField(
                  controller: date,
                  readOnly: true,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Expiry Date',
                      suffixIcon: IconButton(
                          onPressed: () {
                            date.clear();
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
                      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                      date.text = formattedDate;
                    }
                  },
                ),
                ),
              ]),
              actions: [
                TextButton(
                  child: const Text(
                    "Add",
                    style: TextStyle(fontFamily: "Dashiki", fontSize: 20),
                  ),
                  onPressed: () {
                    storeDataToDB();
                  },
                ),
                TextButton(
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontFamily: "Dashiki", fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ]);
        });
  }

  void storeDataToDB() async {
    if (name.text.isEmpty || amount.text.isEmpty || lender.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please fill all the fields"),
      ));
      return;
    }
    Map<String, dynamic> obj = {};
    obj['name'] = name.text;
    obj['amount'] = amount.text;
    obj['lender'] = lender.text;
    obj['date'] = date.text;
    try {
      await db.collection("receivables").add(obj).then((value) => print(value));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Receivables Added Successfully"),
      ));
      name.clear();
      amount.clear();
      lender.clear();
      date.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
      Navigator.pop(context);
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Error Occured"),
      ));
      print(e);
    }
  }

  _sumReceivables(documents, index) {
    return IconButton(
      icon: const Icon(Icons.add_circle_outlined),
      onPressed: () {
        TextEditingController receivables = TextEditingController();
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Add Amount"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: receivables,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Receivables',
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text(
                      "Increase",
                      style: TextStyle(color: Colors.green[300]),
                    ),
                    onPressed: () {
                      if (receivables.text.isEmpty) {
                        return;
                      }
                      try {
                        int parseAmt = 0;
                        var amt = documents[index]['amount'];
                        int parseNewAmt = int.parse(receivables.text);
                        if(amt.runtimeType == String){
                          parseAmt = int.parse(amt);
                        }else{
                          parseAmt = amt;
                        }
                        // parseAmt = int.tryParse(amt);
                        int result = parseAmt + parseNewAmt;  
                        var obj = {
                          'name': documents[index]['name'],
                          'lender': documents[index]['lender'],
                          'amount': result,
                          'date': documents[index]['date'] ?? ''
                        };
                        db
                            .collection("receivables")
                            .doc(documents[index].id)
                            .set(obj);
                      } catch (e) {
                        print(e);
                      }
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: Text(
                      "Decrease",
                      style: TextStyle(color: Colors.red[300]), 
                    ),
                    onPressed: () {
                      if (receivables.text.isEmpty) {
                        return;
                      }
                      int parseAmt = 0;
                        var amt = documents[index]['amount'];
                        int parseNewAmt = int.parse(receivables.text);
                        if(amt.runtimeType == String){
                          parseAmt = int.parse(amt);
                        }else{
                          parseAmt = amt;
                        }
                        // parseAmt = int.tryParse(amt);
                        int result = parseAmt - parseNewAmt;  
                      var obj = {
                        'name': documents[index]['name'],
                        'lender': documents[index]['lender'],
                        'amount': result,
                        'date': documents[index]['date'] ?? ''
                      };
                      db
                          .collection("receivables")
                          .doc(documents[index].id)
                          .set(obj);
                      setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              );
            });
      },
    );
  }

  _deleteReceivables(documents, index) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirmation"),
                content:
                    const Text('Are you sure you want to delete this entry...'),
                actions: [
                  TextButton(
                    child: const Text("Yes"),
                    onPressed: () {
                      db
                          .collection("receivables")
                          .doc(documents[index].id)
                          .delete();
                      setState(() {});
                      Navigator.pop(context);
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
    );
  }
}
