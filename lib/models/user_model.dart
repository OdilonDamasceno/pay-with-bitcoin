class User {
  int _id;
  String _address;

  User(
    this._address,
  );

  User.map(dynamic obj) {
    this._address = obj['address'];
    this._id = obj['id'];
  }

  String get address => _address;

  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['address'] = _address;

    if (id != null) {
      map['id'] = _id;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._address = map['address'];
    this._id = map['id'];
  }
}
