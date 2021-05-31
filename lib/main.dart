import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final random = Random();

Color randomEdgeColor([_]) =>
    Colors.accents[random.nextInt(Colors.accents.length)];

Color randomMiddleColor([_]) =>
    Colors.primaries[random.nextInt(Colors.primaries.length)];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.blue.shade100,
          primarySwatch: Colors.blue,
          cardTheme: CardTheme(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 2, child: LeftEdgeList()),
                  Expanded(flex: 5, child: MiddleList()),
                  Expanded(flex: 3, child: LeftEdgeList()),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Footer(),
              ),
            ],
          ),
        ));
  }
}

class LeftEdgeList extends StatefulWidget {
  @override
  _LeftEdgeListState createState() => _LeftEdgeListState();
}

class _LeftEdgeListState extends State<LeftEdgeList> {
  void addNextItems() =>
      items += List.generate(random.nextInt(10), randomEdgeColor);

  List<Color> items = [];

  @override
  void initState() {
    super.initState();
    addNextItems();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(16),
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      children: [
        for (final item in items)
          SizedBoxItem(
            item: item,
          ),
        OutlinedButton(
          onPressed: () => setState(addNextItems),
          child: Icon(Icons.add_outlined),
        )
      ],
    );
  }
}

class SizedBoxItem extends StatelessWidget {
  final Color item;

  const SizedBoxItem({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Card(
        color: item,
      ),
    );
  }
}

class MiddleList extends StatefulWidget {
  @override
  _MiddleListState createState() => _MiddleListState();
}

class _MiddleListState extends State<MiddleList> {
  @override
  void initState() {
    super.initState();
    addNextItems();
  }

  void addNextItems() =>
      items += List.generate(random.nextInt(20), randomMiddleColor);

  List<Color> items = [];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 75,
            child: Card(
              color: items[index],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              height: 16,
            ),
        itemCount: items.length);
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      color: Colors.blue.shade800,
    );
  }
}
