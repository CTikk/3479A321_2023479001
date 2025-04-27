import 'package:flutter/material.dart';
import 'about.dart';

class ListContentPage extends StatelessWidget {
  ListContentPage({super.key});

  final List<String> items = [
    "Elemento 1",
    "Elemento 2",
    "Elemento 3",
    "Elemento 4",
    "Elemento 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Contenido")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutPage()),
              );
            },
            child: const Text("Ir a About"),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Volver"),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
