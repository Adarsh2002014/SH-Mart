import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import 'package:share/share.dart';

class OilPage extends StatefulWidget {
  var db, p;

  OilPage({super.key, this.db, this.p});

  @override
  State<OilPage> createState() => _OilPageState();
}

class _OilPageState extends State<OilPage> {
  var db, prefs, obj, _apiCalled = false;

  // Future<Object?>? resp;

  @override
  void initState() {
    super.initState();
    db = widget.db;
    prefs = widget.p;
  }

  Future<void> setData() async {
    var response = await db.collection("barCodes").doc("oilList").get();
    DocumentSnapshot data = response as DocumentSnapshot;
    obj = data.data() as Map<String, dynamic>;
    print("SetData is called -----");
    // print(Map.fromEntries(
    //     obj.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key))));
    return;
  }

  returnMap() async {
    if (_apiCalled == false) {
      _apiCalled = true;
      await setData();
      return obj;
    } else {
      print("obj $obj");
      return obj;
    }
  }

  shareData(){
    var data = "";
    obj.forEach((key, value) {
      if(value["current"] != "0"){
        data += "$key : ${value["current"]}Nos\n\n";
      }
    });
    Share.share(data);
  }

  resetData() {
    obj.forEach((key, value) {
      obj[key]["current"] = "0";
      obj[key]["new"] = "0";
    });
    setState(() {});
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Oil Order List",
          style: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 26, fontFamily: "Dashiki", color: Colors.white),
        ),
        backgroundColor: const Color(0xffff7a40),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       print("Save Button $obj");
          //       obj = Map<String, dynamic>.from(obj);
          //       db.collection("barCodes").doc("oilList").set(obj).then((value) {
          //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //           content: Text("Saved Successfully"),
          //           duration: Duration(seconds: 1),
          //         ));
          //       });
          //     },
          //     icon: const Icon(Icons.save_rounded, color: Colors.white)),
          IconButton(
            onPressed: () {
              shareData();
            },
            icon: const Icon(Icons.share_rounded, color: Colors.white,),
          ),
          IconButton(
            onPressed: () {
              resetData();
            },
            icon: const Icon(Icons.refresh_rounded, color: Colors.white,),
          ),
        ],
      ),
      body: FutureBuilder(
          future: returnMap(),
          builder: (context, snapshot) {
            obj = snapshot.data;
            print("obj futurebuilder $obj");
            if (snapshot.hasData) {
              var newmap = {};
              var keys = [...obj.keys]..sort((a, b) => a.compareTo(b));
              for (String key in keys) {
                newmap[key] = obj[key];
              }
              obj = newmap;
              return SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Text(
                    "CottonSeed Oil",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Dashiki"),
                  ),
                  appendCardList("Cotton"),
                  const Text(
                    "Sunflower Oil",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Dashiki"),
                  ),
                  appendCardList("Sunflower"),
                  const Text(
                    "GroundNut Oil",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Dashiki"),
                  ),
                  appendCardList("Groundnut"),
                  const Text(
                    "Corn Oil",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Dashiki"),
                  ),
                  appendCardList("Corn"),
                  const Text(
                    "Rice-Brand Oil",
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Dashiki"),
                  ),
                  appendCardList("Rice")
                ]),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  appendCardList(keyWord){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: obj.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (obj.keys.elementAt(index).contains(keyWord)) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xffff7a40),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(mainAxisSize: MainAxisSize.max, children: [
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      obj.keys.elementAt(index),
                      style: const TextStyle(
                        // backgroundColor:
                        //     const Color(0xffff7a40),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily: "Dashiki",
                      ),
                    ),
                  )),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        increaseOilCount(
                            obj.keys.elementAt(index), 1);
                      },
                      onLongPress: () {
                        decreaseOilCount(
                            obj.keys.elementAt(index), 1);
                      },
                      child: Text(
                        obj[obj.keys.elementAt(index)]["current"]
                            .toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xffff7a40),
                          fontFamily: "Dashiki",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   flex: 2,
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Container(
              //       height: 60,
              //       width: 30,
              //       child: ElevatedButton(
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: const Color(0xffff7a40),
              //           shape: const CircleBorder(),
              //         ),
              //         onPressed: () {
              //           increaseOilCount(
              //               obj.keys.elementAt(index), 2);
              //         },
              //         onLongPress: () {
              //           decreaseOilCount(
              //               obj.keys.elementAt(index), 2);
              //         },
              //         child: Text(
              //           obj[obj.keys.elementAt(index)]["new"]
              //               .toString(),
              //           style: const TextStyle(
              //             fontSize: 20,
              //             fontWeight: FontWeight.w700,
              //             color: Colors.white,
              //             fontFamily: "Dashiki",
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ]),
          );
        } else {
          return const SizedBox
              .shrink(); // Or a placeholder widget
        }
      },
    );
  }

  increaseOilCount(itemKey, mode) {
    print(itemKey);
    if (mode == 1) {
      var count = int.parse(obj[itemKey]["current"]);
      obj[itemKey]["current"] = (count + 1).toString();
      // print(count);
      setState(() {});
    } else if (mode == 2) {
      // print(itemKey);
      print(obj[itemKey]["new"].runtimeType);
      var count = int.parse(obj[itemKey]["new"]);
      obj[itemKey]["new"] = (count + 1).toString();
      setState(() {});
    }
  }

  decreaseOilCount(itemKey, mode) {
    if (mode == 1) {
      var count = int.parse(obj[itemKey]["current"]);
      if (count < 1) {
        return;
      }
      obj[itemKey]["current"] = (--count).toString();
      setState(() {});
    } else if (mode == 2) {
      var count = int.parse(obj[itemKey]["new"]);
      if (count < 1) {
        return;
      }
      obj[itemKey]["new"] = (--count).toString();
      setState(() {});
    }
  }
}
