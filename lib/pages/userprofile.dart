import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/service_news.dart';
import 'package:provider/provider.dart';
import 'package:my_steam_news/data/services/app_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final TextEditingController _idController = TextEditingController();
  final ServiceNews _service = ServiceNews();

  String? _name;
  String? _avatarUrl;

  Future<void> _loadUser(String id) async {
    try {
      final user = await _service.getUserProfile(id);
      final prefs = await SharedPreferences.getInstance();

      // Guardar ID en AppData y preferencias
      context.read<Appdata>().setUsageID(int.parse(id));
      await prefs.setString('steam_id', id);

      setState(() {
        _name = user.name;
        _avatarUrl = user.avatarUrl;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al cargar el usuario: $e')));
    }
  }

  Future<void> _loadSavedSteamId() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getString('steam_id');
    if (savedId != null) {
      _idController.text = savedId;
      _loadUser(savedId);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedSteamId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color.fromARGB(255, 11, 40, 64),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              decoration: const InputDecoration(
                labelText: 'Ingresa tu Steam ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                final id = _idController.text.trim();
                if (id.isNotEmpty) {
                  _loadUser(id);
                }
              },
              child: const Text('Cargar perfil'),
            ),
            const SizedBox(height: 24),
            if (_name != null) ...[
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(_avatarUrl!),
              ),
              const SizedBox(height: 12),
              Text(_name!, style: const TextStyle(fontSize: 20)),
            ],
          ],
        ),
      ),
    );
  }
}
