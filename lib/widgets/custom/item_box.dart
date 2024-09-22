import 'package:flutter/material.dart';

class ItemBox extends StatefulWidget {
  final String name;
  final String priceSale;
  final String priceMrp;
  final String stockAvailable;
  const ItemBox(
      {super.key,
      required this.name,
      required this.priceSale,
      required this.priceMrp,
      required this.stockAvailable});

  @override
  State<ItemBox> createState() => _ItemBoxState();
}

class _ItemBoxState extends State<ItemBox> {
  late ThemeData theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context);
    return Card(
        color: theme.colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 12.0, right: 12.0, bottom: 10.0),
          child: Column(children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.name,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "Dashiki"),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "SH Price: ${widget.priceSale}",
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffff7a40),
                    fontFamily: "Dashiki"),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "MRP: ${widget.priceMrp}",
                style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                    fontFamily: "Dashiki"),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Stock: ${widget.stockAvailable}",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: "Dashiki"),
              ),
            )
          ]),
        ));
    ;
  }
}
