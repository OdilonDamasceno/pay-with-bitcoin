class User {
  int _id;
  String _address;
  String _isTesnet;

  User(
    this._address,
    this._isTesnet,
  );

  User.map(dynamic obj) {
    this._address = obj['address'];
    this._id = obj['id'];
    this._isTesnet = obj['isTestnet'];
  }

  String get address => _address;
  String get isTestnet => _isTesnet;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['address'] = _address;
    map['isTestnet'] = _isTesnet;
    if (id != null) {
      map['id'] = _id;
    }
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._address = map['address'];
    this._id = map['id'];
    this._isTesnet = map['isTestnet'];
  }
}
