import 'package:flutter/material.dart';


class PreferencesPage extends StatefulWidget{
  const PreferencesPage({super.key});
  
  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  
  // Variables de preferencias 
  bool _showNotifications = false;              // Para mostrar notificaciones
  bool _darkMode = false;                       // Modo oscuro
  bool _initWithTheNews = false;                // Iniciar con las novedades
  bool _initWithNewsOfHisGames = false;         // Iniciar con los juegos que sigue


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferencias'),
        backgroundColor: const Color.fromARGB(255, 11, 40, 64),
        titleTextStyle: TextStyle(fontSize: 25),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            title: Center(
              child: Column(
                children: [
                  SwitchListTile(
                    title: Text('Activar Notificaciones', style: TextStyle(color: Colors.white)),
                    value: _showNotifications, 
                    onChanged: (bool value) async{
                      setState(() {
                        _showNotifications = value; 
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Modo oscuro', style: TextStyle(color: Colors.white)),
                    value: _darkMode, 
                    onChanged: (bool value) async{ 
                      setState(() {
                        _darkMode = value; 
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Al iniciar, empezar viendo las novedades', style: TextStyle(color: Colors.white)),
                    value: _initWithTheNews, 
                    onChanged: (bool value) async{
                      setState(() {
                        _initWithTheNews = value; 
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text('Al iniciar, empezar viendo los juegos seguidos', style: TextStyle(color: Colors.white)),
                    value: _initWithNewsOfHisGames, 
                    onChanged: (bool value) async{
                      setState(() {
                        _initWithNewsOfHisGames = value; 
                      });
                    },
                  ),
                ],
              )
            ) 
          ),
        ],
      ),
    );
  }
}
