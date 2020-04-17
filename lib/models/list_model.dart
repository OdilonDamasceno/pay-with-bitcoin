class ListItens {
  static final ListItens _instance = new ListItens.internal();
  factory ListItens() => _instance;
  ListItens.internal();

  final List<Map> list = <Map>[];

  void add(int index, String price) {
    list.add(Map.from({'value': index, 'index': list.length, 'price': price}));
  }

  int remove(int value) {
    for (int i = 0; i < list.length; i++) {
      if (list[i]['index'] == value) {
        list.removeAt(list[value]['index']);
        for (int j = i; j <= list.length - 1; j++) {
          list[j]['index'] = list[j]['index'] - 1;
        }
        return i;
      }
    }
    return 0;
  }

  double finalPrice() {
    double price = 0;
    for (var i = 0; i < list.length; i++) {
      price += double.tryParse(list[i]['price']);
    }
    return double.tryParse(price.toStringAsFixed(8));
  }

  void clear() {
    list.clear();
  }
}
