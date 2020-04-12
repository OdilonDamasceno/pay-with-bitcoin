class User {
  int _id;
  String _address;
  String _productsList;
  User(
    this._address,
    this._productsList,
  );

  User.map(dynamic obj) {
    this._address = obj['address'];
    this._id = obj['id'];
    this._productsList = obj['productList'];
  }

  String get address => _address;
  String get productsList => _productsList;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['address'] = _address;
    map['productsList'] = _productsList;
    if (id != null) {
      map['id'] = _id;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._address = map['address'];
    this._id = map['id'];
    this._productsList = map['productsList'];
  }
}
