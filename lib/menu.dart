import 'package:flutter/material.dart';
import 'package:shmart/login.dart';

class Menu extends StatefulWidget {
  var p;
  Menu({super.key,this.p});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var p,user;

  @override
  void initState() {
    super.initState();
    p = widget.p;
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
              fontWeight: FontWeight.w700, fontSize: 26, fontFamily: "Dashiki",color: Colors.white),
        ),
        backgroundColor: const Color(0xffff7a40),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: (){
            p.setString('username', "");
            p.setString('password', "");
            p.setString('user', "");
            p.setString('valid',"");
            Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
          }, icon: const Icon(Icons.logout_rounded))
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 25,
              mainAxisSpacing: 37,
              crossAxisCount: 2,
              children: menu(context)),
        ),
      ),
    );
  }

  Widget buttons(context, page, icon, text) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      onTap: () {
        Navigator.pushNamed(context, page);
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
    if(user == 'admin'){
      return [
        buttons(context, '/search', Icons.search_rounded, 'Search'),
        buttons(context, '/orderItems', Icons.add_card_rounded,
            'Notes'),
        buttons(context, '/barcodeSticker', Icons.barcode_reader,
            'Req. Barcode'),
        buttons(context, '/oilPage', Icons.oil_barrel_rounded,
            "Oil Order List"),
        buttons(context, '/milkOrder', Icons.water_drop_rounded,
            "Milk Order"),
        buttons(context, '/expiryPage', Icons.date_range_rounded,
            "Expired Items"),
        buttons(context, '/generateOrder', Icons.list_alt_rounded,
            "Order List"),
        buttons(context, '/goalTracker', Icons.track_changes_rounded,
            "Tracker"),
      ];
    }else{
      return [
        buttons(context, '/search', Icons.search_rounded, 'Search'),
        buttons(context, '/orderItems', Icons.add_card_rounded,
            'Notes'),
        buttons(context, '/barcodeSticker', Icons.barcode_reader,
            'Req. Barcode'),
        buttons(context, '/oilPage', Icons.oil_barrel_rounded,
            "Oil Order List"),
        buttons(context, '/generateOrder', Icons.list_alt_rounded,
            "Order List"),
      ];
    }
  }

  getUserName() async {
    user = await widget.p.getString('username');
    setState(() {

    });
  }
}
