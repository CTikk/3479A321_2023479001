import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:application_laboratorio/pages/about.dart';
import 'package:application_laboratorio/pages/list_content.dart';

const String assetName = 'asset/icons/cara.svg';
var logger = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    logger.i("MyHomePage loaded!");
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateBasedOnCounter() {
  if (_counter % 2 == 0) {
    // Si el contador es par, navegar a ListContentPage (list_content.dart)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListContentPage()),
    );
  } else {
    // Si el contador es impar, navegar a AboutPage (about.dart)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AboutPage()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Card(
  color: Colors.grey,
  shadowColor: Colors.black,
  child: Padding(
    padding: const EdgeInsets.only(
      left: 50.0,
      top: 5.0,
      right: 50.0,
      bottom: 5.0,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Haz presionado el botón estas veces: '),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              assetName,
              semanticsLabel: 'cara',
              width: 40,
              height: 40,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              color: Colors.black,
              tooltip: 'Disminuir',
              onPressed: _decrementCounter,
            ),
            IconButton(
              icon: const Icon(Icons.restart_alt_rounded),
              color: Colors.black,
              tooltip: 'Reiniciar',
              onPressed: _resetCounter,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              color: Colors.black,
              tooltip: 'Incrementar',
              onPressed: _incrementCounter,
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: 'Ir a nueva pantalla',
              color: Colors.black,
              onPressed: _navigateBasedOnCounter,
            ),
          ],
        ),
        const SizedBox(height: 10), // Separación
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListContentPage()),
            );
          },
          child: const Text('Ir a Lista'),
        ),
      ],
    ),
  ),
) 
      ),
    );
  }
}
