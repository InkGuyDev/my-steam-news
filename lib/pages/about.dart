import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('No se pudo abrir el enlace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
        backgroundColor: const Color.fromARGB(255, 11, 40, 64),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'MySteamNews',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Esta aplicación permite al usuario ingresar su Steam ID para ver noticias relacionadas con los juegos de su biblioteca.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Desarrollada con Flutter y utilizando la API oficial de Steam para obtener noticias y datos de perfil.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Desarrollado por:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Text('Rodrigo Díaz', style: TextStyle(fontSize: 16)),
            const Text('Ignacio Alfaro', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            const Text(
              'Contacto a:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Text(
              'rdiaz23@alumnos.utalca.cl',
              style: TextStyle(fontSize: 16),
            ),
            const Text(
              'ialfaro23@alumnos.utalca.cl',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _launchUrl('https://store.steampowered.com/'),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Visitar Steam'),
            ),
          ],
        ),
      ),
    );
  }
}
