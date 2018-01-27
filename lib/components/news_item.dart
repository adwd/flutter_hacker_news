import 'package:flutter/material.dart';
import 'dart:core';

class NewsItem extends StatelessWidget {
  final Item item;
  NewsItem(this.item, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) =>
      new ListTile(
        leading: new Row(
          children: <Widget>[
            new Text('${item.index + 1}.'),
            const Icon(Icons.arrow_drop_up)
          ],
        ),
        title: new RichText(
          text: new TextSpan(
            text: item.title,
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              new TextSpan(text: ' '),
              new TextSpan(text: '(${item.site})', style: const TextStyle(
                fontSize: 12.0,
                color: Colors.black54,
              )),
            ],
          ),
        ),
        subtitle: new RichText(
          text: new TextSpan(
            text: '${item.score} points by ${item.by} ${item.hoursAgo} h ago | hide | ${item.descendants} comments',
            style: DefaultTextStyle.of(context).style,
          ),
        ),
      );
}

class Item {
  final int index;
  final String title;
  final String url;
  final int score;
  final String by;
  final int time;
  final int descendants;

  const Item({this.index, this.title, this.url, this.score, this.by, this.time, this.descendants});

  Item.fromMap(Map<String, dynamic> map):
      index = map['index'] ?? 1,
      title = map['title'],
      url = map['url'],
      score = map['score'],
      by = map['by'],
      time = map['time'],
      descendants = map['descendants'];

  String get site => Uri.parse(url).host;

  int get hoursAgo {
    DateTime now = new DateTime.now();
    return  now.difference(new DateTime.fromMillisecondsSinceEpoch(time * 1000)).inHours;
  }

  static Item getMock() => new Item(
    index: 0,
    title: 'USAF Is Jamming GPS in Western U.S. For Largest Ever Red Flag Air War Exercise',
    url: 'http://www.thedrive.com/the-war-zone/17987/usaf-is-jamming-gps-in-the-western-u-s-for-largest-ever-red-flag-air-war-exercise',
    score: 85,
    by: 'tonyztan',
    time: 1517016589,
    descendants:37,
  );
}
