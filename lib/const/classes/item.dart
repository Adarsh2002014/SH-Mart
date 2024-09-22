class Item {
  double? priceMrp;
  String? name;
  double? priceSale;
  double? stockAvailable;

  Item({this.priceMrp, this.name, this.priceSale, this.stockAvailable});

  Item.fromJson(Map<String, dynamic> json) {
    priceMrp = json['price_mrp'] == "" || json['price_mrp'] == null ? 0.0 : json['price_mrp'].toDouble();
    name = json['name'];
    priceSale = json['price_sale'] == "" || json['price_sale'] == null ? 0.0 : json['price_sale'].toDouble();
    stockAvailable = json['stock_available'] == "" || json['stock_available'] == null ? 0.0 : json['stock_available'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price_mrp'] = priceMrp;
    data['name'] = name;
    data['price_sale'] = priceSale;
    data['stock_available'] = stockAvailable;
    return data;
  }
}
