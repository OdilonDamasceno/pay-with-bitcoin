import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:marquee/marquee.dart';
import 'package:pay_with_bitcoin/databases/db_database.dart';
import 'package:pay_with_bitcoin/models/list_model.dart';
import 'package:pay_with_bitcoin/models/user_model.dart';
import 'package:pay_with_bitcoin/repositories/value_repo.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:web_socket_channel/io.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final db = new DB();
  User user;
  @override
  Widget build(BuildContext context) {
    final channel = IOWebSocketChannel.connect(
      'wss://testnet-ws.smartbit.com.au/v1/blockchain',
      pingInterval: Duration(seconds: 20),
    );
    var stream = channel.stream;

    final list = ListItens();
    return Scaffold(
      appBar: AppBar(
        title: Icon(
          Icons.shopping_cart,
          color: Colors.yellow[900],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: list.list.isNotEmpty
          ? Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: FloatingActionButton(
                isExtended: true,
                onPressed: () async {
                  user = await db.getUser(1);
                  channel.sink.add(
                    '{"type":"address","address":"${user.address}"}',
                  );
                  setState(
                    () {
                      showDialog(
                        context: context,
                        child: AlertDialog(
                          content: StreamBuilder(
                              stream: stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (Value().getData(snapshot, user.address) >=
                                      list.finalPrice()) {
                                    SchedulerBinding.instance
                                        .addPostFrameCallback(
                                            (_) => setState(() {
                                                  list.clear();
                                                }));

                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.green,
                                          size: 200,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                              'Final price is: ${list.finalPrice()}'),
                                          Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.5,
                                              child: QrImage(
                                                data:
                                                    'bitcoin:${user.address}?amount=${list.finalPrice()}',
                                                version: QrVersions.auto,
                                                size: 0.1,
                                              ),
                                            ),
                                          ),
                                          Text('Or send to: ${user.address}')
                                        ],
                                      ),
                                    );
                                  }
                                } else {
                                  return Container(
                                      height: 200,
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                }
                              }),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('close'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          : null,
      body: list.list.isNotEmpty
          ? ListView.builder(
              itemCount: list.list.length,
              itemBuilder: (_, index) {
                return FutureBuilder<List>(
                    future: db.getProduct(),
                    builder: (ctx, snapshot) {
                      return snapshot.hasData
                          ? Dismissible(
                              key: ObjectKey(list.list[index]['index']),
                              confirmDismiss: (_) {
                                setState(() {
                                  return list.remove(index);
                                });
                                return;
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(10),
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  boxShadow: [
                                    BoxShadow(blurRadius: 1, color: Colors.grey)
                                  ],
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 90,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: FileImage(
                                            File(
                                              snapshot.data[list.list[index]
                                                  ['value']]['image'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: 20,
                                            width: 220,
                                            child: Marquee(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              pauseAfterRound:
                                                  Duration(seconds: 1),
                                              blankSpace: 330,
                                              text: snapshot.data[
                                                      list.list[index]['value']]
                                                  ['name'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                              scrollAxis: Axis.horizontal,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('Price: '),
                                              Text(snapshot.data[
                                                      list.list[index]
                                                          ['value']]['price'] +
                                                  " BTC"),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Center(child: CircularProgressIndicator());
                    });
              },
            )
          : Center(
              child: Padding(
                padding: EdgeInsets.only(top: 300),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.remove_shopping_cart,
                      color: Colors.yellow[900],
                      size: 90,
                    ),
                    Text(
                      'Without items',
                      style: TextStyle(color: Colors.yellow[900], fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
