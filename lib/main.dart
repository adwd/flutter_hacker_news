import 'package:flutter/material.dart';

import 'package:flutter_hacker_news/components/news_item.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: new MyHomePage(title: 'Hacker News Flutter'),
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
          child: const Icon(const IconData(89))
        ), // code point for 'Y'
      ),
      body: new ListView(
        children: <Widget>[
          new NewsItem(Item.getMock()),
        ],
      ),
    );
  }
}
