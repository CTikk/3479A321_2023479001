import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:application_laboratorio/pages/about.dart';
import 'package:application_laboratorio/pages/list_content.dart';
import 'package:application_laboratorio/pages/preference_page.dart';
import 'package:application_laboratorio/provider/app_data.dart';
import 'package:application_laboratorio/pages/activity_page.dart';

const String assetName = 'asset/icons/cara.svg';
var logger = Logger();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _resetAllowed = true;

  _MyHomePageState() {
    logger.i("Constructor ejecutado - mounted: \$mounted");
  }

  @override
  void initState() {
    super.initState();
    logger.i("initState ejecutado");
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _resetAllowed = prefs.getBool('isResetEnabled') ?? true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i("didChangeDependencies ejecutado");
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    logger.i("setState ejecutado");
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i("didUpdateWidget ejecutado");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.i("deactivate ejecutado");
  }

  @override
  void dispose() {
    super.dispose();
    logger.i("dispose ejecutado");
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i("reassemble ejecutado (hot reload)");
  }

  void _navigateBasedOnCounter() {
    int counter = context.read<AppData>().counter;
    if (counter % 2 == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListContentPage()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AboutPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build ejecutado");
    final appData = context.watch<AppData>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Text('Menú de Navegación'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Lista de elementos'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListContentPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Detalle / About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Preferencias'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PreferencePage()),
                ).then((_) {
                  _loadPreferences();
                });
              },
            ),
            ListTile(
              title: const Text('Actividades'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ActivityPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Card(
          color: Colors.grey,
          shadowColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Bienvenido, ${appData.username}"),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Haz presionado el botón estas veces: '),
                    Text(
                      '${appData.counter}',
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
                      onPressed: () => context.read<AppData>().decrementCounter(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.restart_alt_rounded),
                      color: Colors.black,
                      tooltip: 'Reiniciar',
                      onPressed: _resetAllowed
                          ? () => context.read<AppData>().resetCounter()
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      color: Colors.black,
                      tooltip: 'Incrementar',
                      onPressed: () => context.read<AppData>().incrementCounter(),
                    ),
                    IconButton(
                      icon: const Icon(Icons.navigate_next),
                      tooltip: 'Ir a nueva pantalla',
                      color: Colors.black,
                      onPressed: _navigateBasedOnCounter,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
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
        ),
      ),
    );
  }
}
