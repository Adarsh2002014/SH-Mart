import 'package:shmart/shmart.dart';


class MilkOrder extends StatefulWidget {
  const MilkOrder({super.key});

  @override
  State<MilkOrder> createState() => _MilkOrderState();
}

class _MilkOrderState extends State<MilkOrder> {
  late ThemeData theme;
  TextEditingController milk500mlController = TextEditingController();
  TextEditingController milk1ltrController = TextEditingController();
  TextEditingController buttermilk200mlController = TextEditingController();
  TextEditingController dahi85mlController = TextEditingController();
  TextEditingController dahi200mlController = TextEditingController();
  TextEditingController dahi400mlController = TextEditingController();
  TextEditingController dahi1ltrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(dailyDairyOrder),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                milkItem,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CusTextfield(
                    controller: milk500mlController,
                    hintText: "500ml",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CusTextfield(
                    controller: milk1ltrController,
                    hintText: "1ltr",
                  )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                dahiItem,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CusTextfield(
                    controller: dahi85mlController,
                    hintText: "85ml",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CusTextfield(
                    controller: dahi200mlController,
                    hintText: "200ml",
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CusTextfield(
                    controller: dahi400mlController,
                    hintText: "400ml",
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CusTextfield(
                    controller: dahi1ltrController,
                    hintText: "1ltr",
                  )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                buttermilkItem,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                      child: CusTextfield(
                    controller: buttermilk200mlController,
                    hintText: "200ml",
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                  onPressed: _shareOrder,
                  label: const Text("Share"),
                  icon: const Icon(Icons.share_rounded))
            ],
          ),
        ),
      ),
    );
  }

  void _shareOrder(){
    String message = "";
    if(milk500mlController.text != ""){
      message = "Milk 500ml: ${double.parse(milk500mlController.text) * 24}\n";
    }
    if(milk1ltrController.text != ""){
      message += "Milk 1ltr: ${double.parse(milk1ltrController.text) * 12}\n";
    }
    if(buttermilk200mlController.text != ""){
      message += "Buttermilk(Chaas) 330ml: ${double.parse(buttermilk200mlController.text) * 36}\n";
    }
    if(dahi85mlController.text != ""){
      message += "Dahi 85ml: ${double.parse(dahi85mlController.text) * 48}\n";
    }
    if(dahi200mlController.text != ""){
      message += "Dahi 200ml: ${double.parse(dahi200mlController.text) * 24}\n";
    }
    if(dahi400mlController.text != ""){
      message += "Dahi 400ml: ${double.parse(dahi400mlController.text) * 30}\n";
    }
    if(dahi1ltrController.text != ""){
      message += "Dahi 1ltr: ${double.parse(dahi1ltrController.text) * 12}\n";
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
