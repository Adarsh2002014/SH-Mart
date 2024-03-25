import 'package:flutter/material.dart';
import 'package:share/share.dart';

class MilkOrder extends StatelessWidget {
  MilkOrder({super.key});
  TextEditingController milk500 = TextEditingController();
  TextEditingController milk1000 = TextEditingController();
  TextEditingController buttermilk = TextEditingController();
  TextEditingController dahi10 = TextEditingController();
  TextEditingController dahi22 = TextEditingController();
  TextEditingController dahi400 = TextEditingController();
  TextEditingController dahi1000 = TextEditingController();


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
          "Milk Order",
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 26,
              fontFamily: "Dashiki",
              color: Colors.white),

        ),
        backgroundColor: const Color(0xffff7a40),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
          child: Column(
            children: [
              textfield("Milk 500ml", milk500),
              textfield("Milk 1ltr", milk1000),
              textfield("Buttermilk (Chass)", buttermilk),
              textfield("Dahi 10RS", dahi10),
              textfield("Dahi 22RS", dahi22),
              textfield("Dahi 400gm", dahi400),
              textfield("Dahi 1ltr", dahi1000),
              Container(
                padding: const EdgeInsets.only(top: 8),
                width: double.infinity,
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    shareValue(context);
                  },
                  icon: const Icon(Icons.share_rounded, color: Colors.white),
                  label: const Text(
                    "Share Order",
                    style:
                    TextStyle(fontFamily: "Dashiki", color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xffff7a40)),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                        const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget textfield(placeholder, controller){
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: placeholder,
          suffixIcon: IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(Icons.clear)),
        ),
        controller: controller,
      ),
    );
  }

  shareValue(context){
    String message = "";
    if(milk500.text != ""){
      message = "Milk 500ml: ${milk500.text}\n";
      print("Milk: ${milk500.text}");
    }
    if(milk1000.text != ""){
      message += "Milk 1ltr: ${milk1000.text}\n";
      print("Milk: ${milk1000.text}");
    }
    if(buttermilk.text != ""){
      message += "Buttermilk(Chaas) 330ml: ${buttermilk.text}\n";
      print("Buttermilk: ${buttermilk.text}");
    }
    if(dahi10.text != ""){
      message += "Dahi 10Rs: ${dahi10.text}\n";
      print("Dahi 10RS: ${dahi10.text}");
    }
    if(dahi22.text != ""){
      message += "Dahi 22Rs: ${dahi22.text}\n";
      print("Dahi 22RS: ${dahi22.text}");
    }
    if(dahi400.text != ""){
      message += "Dahi 34Rs: ${dahi400.text}\n";
      print("Dahi 400gm: ${dahi400.text}");
    }
    if(dahi1000.text != ""){
      message += "Dahi 72Rs: ${dahi1000.text}\n";
      print("Dahi 1ltr: ${dahi1000.text}");
    }
    if(message == ""){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter the quantity"),
          )
      );
    }else{
      Share.share(message);
    }
  }
}
