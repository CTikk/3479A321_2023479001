import 'dart:io';
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  final List<File> images;

  const GalleryPage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Galería')),
      body: images.isEmpty
          ? const Center(child: Text('No hay imágenes aún.'))
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Image.file(images[index], fit: BoxFit.cover);
              },
            ),
    );
  }
}