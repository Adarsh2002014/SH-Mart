import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shmart/screens/old_screens/helper/NewUpdate.dart';

class Menu extends StatefulWidget {
  final p, dbobj;
  const Menu({super.key, required this.p, required this.dbobj});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var p, user, db;
  bool showUpdate = false;
  NewUpdate updateApk = NewUpdate();
  late Stream<double> updateValues;

  @override
  void initState() {
    super.initState();
    p = widget.p;
    db = widget.dbobj;
    getUserName();
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
          "   Sh Mart Menu's",
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
                p.setString('username', "");
                p.setString('password', "");
                p.setString('user', "");
                p.setString('valid', "");
                Navigator.pushNamedAndRemoveUntil(
                    context, "/login", (route) => false);
              },
              icon: const Icon(Icons.logout_rounded)),
          _checkUpdate(),
          showUpdate
              ? StreamBuilder(
                  stream: updateValues,
                  builder: (context, value) {
                    print(value.hasData ? value.data : 0.0);
                    if (value.hasData) {
                      if (value.data == 1.0) {
                        validateToUpdate();
                        return Container();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          width: 15,
                          height: 15,
                          child: CircularProgressIndicator(
                            value: value.hasData ? value.data as double : 0.0,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }else{
                      if(value.hasError){
                        //show snack bar the error
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.error.toString())));
                      }
                      return Container();
                    }
                  })
              : Container(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            tasksCard(),
            Container(
              child: GridView.count(
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 37,
                  crossAxisCount: 2,
                  children: menu(context)),
            ),
          ],
        ),
      ),
    );
  }

  tasksCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 5),
      child: Card(
        color: const Color.fromARGB(255, 252, 111, 51),
        child: FutureBuilder(
            future: db.collection("itemNames").get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot =
                    snapshot.data as QuerySnapshot<Object?>;
                List<DocumentSnapshot> documents = querySnapshot.docs;
                if (documents.isEmpty) {
                  return Container();
                }
                int loopCount = documents.length;
                if (loopCount > 5) {
                  loopCount = 5;
                }
                print("Length of the list is $loopCount");
                return Column(mainAxisSize: MainAxisSize.min, children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 5),
                      child: Text(
                        "Necessary Tasks:",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Dashiki',
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: loopCount,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: ListTile(
                                title: Text(
                                  documents[index]['orderItem'],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Dashiki'),
                                ),
                                subtitle: Text(
                                  documents[index]['orderQuantity'],
                                  style: const TextStyle(
                                      color: Colors.white54,
                                      fontFamily: 'Dashiki'),
                                ),
                                tileColor:
                                    const Color.fromARGB(255, 255, 139, 90),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          );
                        }),
                  )
                ]);
              }
              return Container();
            }),
      ),
    );
  }

  Widget buttons(context, page, icon, text) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      onTap: () {
        Navigator.pushNamed(context, page).then((value) => setState(() {}));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: const Color(0xffff7a40), width: 2),
          // color: Color(0xffff7a40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xffff7a40),
              size: 50,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Color(0xffff7a40),
                  fontSize: 20,
                  fontFamily: 'Dashiki',
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> menu(context) {
    print(user);
    if (user == 'admin') {
      return [
        buttons(context, '/search', Icons.search_rounded, 'Search'),
        buttons(context, '/orderItems', Icons.add_card_rounded, 'Notes'),
        buttons(
            context, '/barcodeSticker', Icons.barcode_reader, 'Req. Barcode'),
        buttons(
            context, '/oilPage', Icons.oil_barrel_rounded, "Oil Order List"),
        buttons(context, '/milkOrder', Icons.water_drop_rounded, "Milk Order"),
        buttons(
            context, '/expiryPage', Icons.date_range_rounded, "Expired Items"),
        buttons(
            context, '/generateOrder', Icons.list_alt_rounded, "Order List"),
        buttons(
            context, '/goalTracker', Icons.track_changes_rounded, "Tracker"),
        buttons(
            context, '/rackLabelPage', Icons.video_label_rounded, "Rack Label"),
        buttons(context, '/receivables', Icons.currency_rupee_rounded,
            "Receivables"),
      ];
    } else {
      return [
        buttons(context, '/search', Icons.search_rounded, 'Search'),
        buttons(context, '/orderItems', Icons.add_card_rounded, 'Notes'),
        buttons(
            context, '/barcodeSticker', Icons.barcode_reader, 'Req. Barcode'),
        buttons(
            context, '/oilPage', Icons.oil_barrel_rounded, "Oil Order List"),
        buttons(
            context, '/generateOrder', Icons.list_alt_rounded, "Order List"),
      ];
    }
  }

  getUserName() async {
    user = await widget.p.getString('username');
    setState(() {});
  }

  _checkUpdate() {
    return IconButton(
        onPressed: () async {
          bool isThereUpdate = await NewUpdate().checkIsThereUpdate();
          if (isThereUpdate) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("System Update"),
                    content: const Text(
                        "There is new update available!! You want to update"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          PermissionStatus permission =
                              await Permission.storage.request();
                          if (await permission.isGranted) {
                            Directory expectedDirectory = await getApplicationDocumentsDirectory();
                            String path = "${expectedDirectory.path}/a.apk";
                            File file = File(path);
                            if (await file.existsSync()) {
                              file.deleteSync();
                            }
                            print("After the file delete");
                            await updateApk.setDownloadPath();
                            updateValues = updateApk.downloadUpdateApk();
                            showUpdate = true;
                            Navigator.pop(context);
                            setState(() {});
                          }
                        },
                        child: const Text("Ok"),
                      ),
                    ],
                  );
                });
          } else {
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('System Update'),
                content: const Text('Current system is up to date!!'),
                actions: [
                  TextButton(onPressed: (){Navigator.pop(context);},child: const Text('Ok'),),
                ],
              );
            });
          }
        },
        icon: const Icon(Icons.upload));
  }
  
  void validateToUpdate() {
    updateApk.installApk();
  }
}
