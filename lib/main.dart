import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shmart/orderItems.dart';
import 'package:shmart/menu.dart';
import 'package:shmart/oilPage.dart';
import 'package:shmart/SearchPage.dart';
import 'package:shmart/login.dart';
import 'package:shmart/milkOrder.dart';
import 'package:shmart/expiryPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shmart/rackLabel.dart';
import 'package:shmart/receivables.dart';
import 'firebase_options.dart';
import 'package:shmart/barcodeSticker.dart';

import 'generateOrder.dart';
import 'goalDetails.dart';
import 'goalTracker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var db = FirebaseFirestore.instance;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MainApp(pref: prefs, dbobj: db));
}

// ignore: must_be_immutable
class MainApp extends StatefulWidget {
  var pref, dbobj;

  MainApp({super.key, this.pref, this.dbobj});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    var p = widget.pref;
    var dbobj = widget.dbobj;
    var loggedIn;
    try{
      loggedIn = p.getString('valid');
    } catch (e) {
      loggedIn = "false";
    }

    return MaterialApp(
      title: 'ShMart',
      theme: ThemeData(fontFamily: 'Dashiki', primaryColor: Colors.white),
      darkTheme: ThemeData.dark(),
      home:loggedIn == "true"? Menu(p:p, dbobj: dbobj,) : Login(p: p, dbobj: dbobj),
      debugShowCheckedModeBanner: false,
      // initialRoute: "/menu",
      routes: {
        "/login": (context) => Login(p: p, dbobj: dbobj),
        "/menu": (context) => Menu(p: p, dbobj: dbobj,),
        "/search": (context) => SearchPage(p: p),
        "/orderItems": (context) => OrderItems(p: p, dbobj: dbobj),
        "/barcodeSticker": (context) => BarcodeSticker(db: dbobj, p: p),
        "/oilPage": (context) => OilPage(db: dbobj, p: p),
        "/milkOrder": (context) => MilkOrder(),
        "/expiryPage": (context) => ExpiryPage(dbobj: dbobj, p: p),
        "/generateOrder": (context) => GenerateOrder(p: p),
        "/goalTracker": (context) => GoalTracker(dbobj: dbobj),
        "/goalDetails": (context) => GoalDetails(dbobj: dbobj),
        "/rackLabelPage": (context) => RackLabel(p:p, dbobj: dbobj),
        "/receivables": (context) => Receivables(dbobj: dbobj),
      },
    );
  }
}
