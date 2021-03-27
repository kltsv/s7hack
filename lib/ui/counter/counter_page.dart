import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      _cacheCounter(_counter);
    });
  }

  void _cacheCounter(int counter) =>
      di.cache.save('counter', {'value': counter});

  void _loadCounter() {
    final raw = di.cache.load('counter');
    if (raw != null) {
      _counter = raw['value'] as int;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
