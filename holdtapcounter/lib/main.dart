import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  int _counter = 0;
  Timer _timer;

  void _incrementOnTapCounter() {
    setState(() {
      _counter++;
    });
  }

  void _incrementOnTapDownCounter() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (t) {
      setState(() {
        _counter++;
      });
    });
  }

  void _incrementOnTapUpCounter() {
    _timer.cancel();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: <Widget>[
            TopSection(handleClick: _resetCounter),
            MiddleSection(count: _counter),
            BottomSection(
              handleClick: _incrementCounter,
              handleTap: _incrementOnTapCounter,
              handleTapDown: _incrementOnTapDownCounter,
              handleTapUp: _incrementOnTapUpCounter,
            )
          ],
        ),
      ),
    );
  }
}

class TopSection extends StatelessWidget {
  const TopSection({
    Key key,
    this.handleClick,
  }) : super(key: key);

  final VoidCallback handleClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                    child: FlatButton(
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    this.handleClick();
                  },
                  child: Text(
                    "Reset Me",
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MiddleSection extends StatelessWidget {
  const MiddleSection({
    Key key,
    this.count,
  }) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                  child: Text(
                    '$count',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSection extends StatelessWidget {
  const BottomSection(
      {Key key,
      this.handleClick,
      this.handleTap,
      this.handleTapDown,
      this.handleTapUp})
      : super(key: key);

  final VoidCallback handleClick;
  final VoidCallback handleTap;
  final VoidCallback handleTapDown;
  final VoidCallback handleTapUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*2*/
                Container(
                  child: FlatButton(
                    onPressed: handleClick,
                    color: Colors.blue,
                    textColor: Colors.white,
                    child: Text(
                      "Tap Me",
                    ),
                  ),
                ),
                Container(
                    color: Colors.blue,
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: handleTap,
                      onTapDown: (TapDownDetails tapDownDetails) {
                        handleTapDown();
                      },
                      onTapUp: (TapUpDetails tapUpDetails) {
                        handleTapUp();
                      },
                      child: Text(
                        "Tap and hold",
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
