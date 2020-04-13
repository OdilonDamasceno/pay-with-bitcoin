class Item {
  String _name;
  String _description;
  double _price;
  String _image;
  Item(
    this._description,
    this._image,
    this._name,
    this._price,
  );
  Item.map(dynamic obj) {
    this._description = obj['description'];
    this._image = obj['image'];
    this._name = obj['name'];
    this._price = obj['price'];
  }
  String get name => _name;
  String get description => _description;
  double get price => _price;
  String get image => _image;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['name'] = _name;
    map['description'] = _description;
    map['price'] = _price;
    map['image'] = _image;
    return map;
  }

  Item.fromMap(Map<String, dynamic> map) {
    this._description = map['description'];
    this._image = map['image'];
    this._name = map['name'];
    this._price = map['price'];
  }
}
