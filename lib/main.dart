import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kFastDuration = Duration(milliseconds: 200);
final random = Random();

MaterialAccentColor randomEdgeColor([_]) => Colors.accents[random.nextInt(Colors.accents.length)];

MaterialColor randomMiddleColor([_]) => Colors.primaries[random.nextInt(Colors.primaries.length)];

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
              clipBehavior: Clip.antiAlias,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ))),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
              Center(
                child: Container(
                  width: 1280, // max width
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: LeftEdgeList()),
                      Expanded(flex: 5, child: MiddleList()),
                      Expanded(flex: 3, child: RightEdgeList()),
                    ],
                  ),
                ),
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
  void addNextItems() => items += List.generate(random.nextInt(10) + 1, randomEdgeColor);

  List<Color> items = [];

  @override
  void initState() {
    super.initState();
    addNextItems();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: items.length + 1,
      // plus end button
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return LeftItem(
            item: items[index],
          );
        } else {
          return OutlinedButton(
            onPressed: () => setState(addNextItems),
            child: Icon(Icons.add_outlined),
          );
        }
      },
      shrinkWrap: true,
    );
  }
}

class LeftItem extends StatelessWidget {
  final Color item;

  const LeftItem({Key? key, required this.item}) : super(key: key);

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

  void addNextItems() => items += List.generate(random.nextInt(10) + 1, randomMiddleColor);

  List<MaterialColor> items = [];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 16),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index < items.length) {
            return MiddleItem(
              item: items[index],
            );
          } else {
            return OutlinedButton(
              onPressed: () => setState(addNextItems),
              child: Icon(Icons.add_outlined),
            );
          }
        },
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemCount: items.length + 1);
  }
}

class MiddleItem extends StatefulWidget {
  const MiddleItem({Key? key, required this.item}) : super(key: key);
  final MaterialColor item;

  @override
  _MiddleItemState createState() => _MiddleItemState();
}

class _MiddleItemState extends State<MiddleItem> with SingleTickerProviderStateMixin {
  bool isExpanded = false;

  late List<Color> subItems = widget.item.colors.reversed.toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: subItems.first,
      child: Stack(
        children: [
          AnimatedSize(
            vsync: this,
            duration: kFastDuration,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isExpanded)
                  for (final color in subItems)
                    Container(
                      height: 48,
                      color: color,
                    )
                else
                  Container(
                    height: 48,
                    color: subItems.first,
                  )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                icon: Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                onPressed: () => setState(() {
                  isExpanded = !isExpanded;
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RightEdgeList extends StatefulWidget {
  @override
  _RightEdgeListState createState() => _RightEdgeListState();
}

class _RightEdgeListState extends State<RightEdgeList> {
  void addNextItems() => items += List.generate(random.nextInt(5) + 1, randomEdgeColor);

  List<MaterialAccentColor> items = [];

  @override
  void initState() {
    super.initState();
    addNextItems();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length + 1,
      // plus end button
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        if (index < items.length) {
          return RightItem(
            item: items[index].shade100,
          );
        } else {
          return OutlinedButton(
            onPressed: () => setState(addNextItems),
            child: Icon(Icons.add_outlined),
          );
        }
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      shrinkWrap: true,
    );
  }
}

class RightItem extends StatefulWidget {
  final Color item;

  const RightItem({Key? key, required this.item}) : super(key: key);

  @override
  _RightItemState createState() => _RightItemState();
}

class _RightItemState extends State<RightItem> with SingleTickerProviderStateMixin {
  void addNextItems() => items += List.generate(random.nextInt(10) + 1, (index) => items.length + index);

  @override
  void initState() {
    super.initState();
    addNextItems();
  }

  List<int> items = [];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: widget.item,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedSize(
          vsync: this,
          duration: kFastDuration,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 8,
            spacing: 8,
            children: [
              for (final item in items)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      '$item',
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ),
              IconButton(
                onPressed: () => setState(addNextItems),
                icon: Icon(Icons.add_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(30),
      alignment: Alignment.center,
      color: Colors.blue.shade800,
      child: Text(
        'FOOTER',
        style: theme.textTheme.headline2?.copyWith(color: Colors.white70),
      ),
    );
  }
}

extension on MaterialColor {
  static const shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

  List<Color> get colors => shades.map((shade) => this[shade]).whereNotNull().toList(growable: false);
}
