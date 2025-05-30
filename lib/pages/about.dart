import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:application_laboratorio/provider/app_data.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();
    final controller = TextEditingController(text: appData.username);

    return Scaffold(
      appBar: AppBar(title: const Text("Sobre")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Aplicación de Flutter\nLaboratorio de Dispositivos Móviles",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Nombre de usuario",
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                context.read<AppData>().setUsername(value);
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Volver"),
            ),
          ],
        ),
      ),
    );
  }
}
