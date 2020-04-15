class ListItens {
  static final ListItens _instance = new ListItens.internal();
  factory ListItens() => _instance;
  ListItens.internal();

  final List<Map> list = <Map>[];

  void add(int value) {
    list.add(Map.from({'value': value, 'index': list.length}));
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
  }
}
