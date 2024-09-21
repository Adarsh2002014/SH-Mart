class Item {
  int? profitMargin;
  int? priceMrp;
  int? id;
  String? createdOn;
  String? modifiedOn;
  int? accounteeId;
  String? parentId;
  String? number;
  String? name;
  String? brandName;
  String? hsnsacCode;
  String? details;
  String? categoryName;
  String? uqcCode;
  int? pricePurchase;
  int? priceSale;
  String? currencyCode;
  int? taxPercentage;
  int? cessPercentage;
  String? taxType;
  int? reverseCharge;
  int? stockMinimum;
  int? stockMaximum;
  int? stockThreshold;
  String? storageLocation;
  String? barcodeValue;
  double? weightKg;
  String? weightUqcCode;
  String? images;
  int? points;
  String? categoryPrices;
  String? lastInwardDate;
  String? lastOutwardDate;
  int? status;
  int? pricePurchaseNet;
  int? profitAmount;
  int? priceSaleGross;
  int? priceMrpSaleDiffAmount;
  int? priceMrpSaleDiffPercentage;
  int? daysSinceLastInward;
  int? daysSinceLastOutward;
  int? stockAvailable;

  Item(
      {this.profitMargin,
      this.priceMrp,
      this.id,
      this.createdOn,
      this.modifiedOn,
      this.accounteeId,
      this.parentId,
      this.number,
      this.name,
      this.brandName,
      this.hsnsacCode,
      this.details,
      this.categoryName,
      this.uqcCode,
      this.pricePurchase,
      this.priceSale,
      this.currencyCode,
      this.taxPercentage,
      this.cessPercentage,
      this.taxType,
      this.reverseCharge,
      this.stockMinimum,
      this.stockMaximum,
      this.stockThreshold,
      this.storageLocation,
      this.barcodeValue,
      this.weightKg,
      this.weightUqcCode,
      this.images,
      this.points,
      this.categoryPrices,
      this.lastInwardDate,
      this.lastOutwardDate,
      this.status,
      this.pricePurchaseNet,
      this.profitAmount,
      this.priceSaleGross,
      this.priceMrpSaleDiffAmount,
      this.priceMrpSaleDiffPercentage,
      this.daysSinceLastInward,
      this.daysSinceLastOutward,
      this.stockAvailable});

  Item.fromJson(Map<String, dynamic> json) {
    profitMargin = json['profit_margin'];
    priceMrp = json['price_mrp'];
    id = json['id'];
    createdOn = json['created_on'];
    modifiedOn = json['modified_on'];
    accounteeId = json['accountee_id'];
    parentId = json['parent_id'];
    number = json['number'];
    name = json['name'];
    brandName = json['brand_name'];
    hsnsacCode = json['hsnsac_code'];
    details = json['details'];
    categoryName = json['category_name'];
    uqcCode = json['uqc_code'];
    pricePurchase = json['price_purchase'];
    priceSale = json['price_sale'];
    currencyCode = json['currency_code'];
    taxPercentage = json['tax_percentage'];
    cessPercentage = json['cess_percentage'];
    taxType = json['tax_type'];
    reverseCharge = json['reverse_charge'];
    stockMinimum = json['stock_minimum'];
    stockMaximum = json['stock_maximum'];
    stockThreshold = json['stock_threshold'];
    storageLocation = json['storage_location'];
    barcodeValue = json['barcode_value'];
    weightKg = json['weight_kg'];
    weightUqcCode = json['weight_uqc_code'];
    images = json['images'];
    points = json['points'];
    categoryPrices = json['category_prices'];
    lastInwardDate = json['last_inward_date'];
    lastOutwardDate = json['last_outward_date'];
    status = json['status'];
    pricePurchaseNet = json['price_purchase_net'];
    profitAmount = json['profit_amount'];
    priceSaleGross = json['price_sale_gross'];
    priceMrpSaleDiffAmount = json['price_mrp_sale_diff_amount'];
    priceMrpSaleDiffPercentage = json['price_mrp_sale_diff_percentage'];
    daysSinceLastInward = json['days_since_last_inward'];
    daysSinceLastOutward = json['days_since_last_outward'];
    stockAvailable = json['stock_available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profit_margin'] = profitMargin;
    data['price_mrp'] = priceMrp;
    data['id'] = id;
    data['created_on'] = createdOn;
    data['modified_on'] = modifiedOn;
    data['accountee_id'] = accounteeId;
    data['parent_id'] = parentId;
    data['number'] = number;
    data['name'] = name;
    data['brand_name'] = brandName;
    data['hsnsac_code'] = hsnsacCode;
    data['details'] = details;
    data['category_name'] = categoryName;
    data['uqc_code'] = uqcCode;
    data['price_purchase'] = pricePurchase;
    data['price_sale'] = priceSale;
    data['currency_code'] = currencyCode;
    data['tax_percentage'] = taxPercentage;
    data['cess_percentage'] = cessPercentage;
    data['tax_type'] = taxType;
    data['reverse_charge'] = reverseCharge;
    data['stock_minimum'] = stockMinimum;
    data['stock_maximum'] = stockMaximum;
    data['stock_threshold'] = stockThreshold;
    data['storage_location'] = storageLocation;
    data['barcode_value'] = barcodeValue;
    data['weight_kg'] = weightKg;
    data['weight_uqc_code'] = weightUqcCode;
    data['images'] = images;
    data['points'] = points;
    data['category_prices'] = categoryPrices;
    data['last_inward_date'] = lastInwardDate;
    data['last_outward_date'] = lastOutwardDate;
    data['status'] = status;
    data['price_purchase_net'] = pricePurchaseNet;
    data['profit_amount'] = profitAmount;
    data['price_sale_gross'] = priceSaleGross;
    data['price_mrp_sale_diff_amount'] = priceMrpSaleDiffAmount;
    data['price_mrp_sale_diff_percentage'] = priceMrpSaleDiffPercentage;
    data['days_since_last_inward'] = daysSinceLastInward;
    data['days_since_last_outward'] = daysSinceLastOutward;
    data['stock_available'] = stockAvailable;
    return data;
  }
}
