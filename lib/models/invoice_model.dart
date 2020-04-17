import 'package:pay_with_bitcoin/models/item_model.dart';

class Invoice {
  List<Item> list;
  double finalPrice;
  Invoice(this.list, this.finalPrice);

  Invoice.map(dynamic obj) {
    this.list = obj['listItens'];
    this.finalPrice = obj['price'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['price'] = finalPrice;
    map['listItens'] = list;

    return map;
  }

  Invoice.fromMap(Map<String, dynamic> map) {
    this.finalPrice = map['price'];
    this.list = map['listItens'];
  }
}
