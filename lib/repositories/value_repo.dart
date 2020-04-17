import 'dart:convert';
import 'package:flutter/material.dart';

class Value {
  double getData(AsyncSnapshot snapshot, String address) {
    Map map = json.decode(snapshot.data);

    if (map['type'] == 'address' && map['payload']['address'] == address) {
      int count = map['payload']['transaction']['output_count'];
      for (var i = 0; i < count; i++) {
        if (List.from(map['payload']['transaction']['outputs'][i]['addresses'])
            .contains(address)) {
          return double.tryParse(
              map['payload']['transaction']['outputs'][i]['value']);
        }
      }
    }
    return 0;
  }
}
