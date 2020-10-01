import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter_hacker_news/components/news_item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'HackR News',
      theme: new ThemeData(
        primarySwatch: Colors.white,
      ),
      home: new MyHomePage(title: 'HackR News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = [];
  @override
  initState() async {
    print('init state');
    List<int> ids = await http.get('https://hacker-news.firebaseio.com/v0/topstories.json')
    .then((http.Response res) => JSON.decode(res.body) as List<int>);

    List<Item> results = await Future.wait(
        ids.take(10)
          .map((int id) => http.get('https://hacker-news.firebaseio.com/v0/item/${id.toString()}.json')
          .then((http.Response res) {
            var b = JSON.decode(res.body);
            var i = new Item.fromMap(b);
            print(i.toString());
            return i;
          }))
    );

    setState(() {
      items = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        leading: new Container(
          decoration: const BoxDecoration(
            border: const Border(
              top: const BorderSide(width: 1.0, color: const Color(0xFFFFFFFFFF)),
              left: const BorderSide(width: 1.0, color: const Color(0xFFFFFFFFFF)),
              right: const BorderSide(width: 1.0, color: const Color(0xFFFFFFFFFF)),
              bottom: const BorderSide(width: 1.0, color: const Color(0xFFFFFFFFFF)),
            )
          ),
          margin: new EdgeInsets.all(8.0),
          child: const Icon(const IconData(89)) // code point for 'Y'
        ),
      ),
      body: new ListView(
        children: items.map((Item item) => new NewsItem(item)).toList()
      ),
    );
  }
}
