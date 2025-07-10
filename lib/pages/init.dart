import 'package:flutter/material.dart';
import 'package:my_steam_news/pages/favorite.dart';
import 'package:my_steam_news/pages/home.dart';
import 'package:my_steam_news/pages/others.dart';
import 'package:my_steam_news/pages/preferences.dart';
import 'package:my_steam_news/pages/search.dart';
import 'package:my_steam_news/pages/userprofile.dart';


// Pagina Home de la aplicación, la que aparece al ingresar
class InitPage extends StatefulWidget {
  const InitPage({super.key, required this.title});
  final String title;

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  int currentPageIndex = 0;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(65), // AppBar principal, este nunca cambia y se mantiene en toda la aplicación
        child: AppBar( 
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ //Diferentes botones superiores y el logo de la app: Usuario, Logo, Preferencias
              IconButton( icon: const Icon(Icons.person, color: Colors.white, size: 35,),
                onPressed: () { changeToUserPage(context); }, ),
              Text('Insertar logo Aqui', style: TextStyle(color: Colors.white, fontSize: 18)),
              IconButton( icon: const Icon(Icons.settings, color: Colors.white, size: 35,),
                onPressed: () { changeToPreferencesPage(context); }, ),
            ],
          ),
        ),
      ),
      // Botones en el pie del inicio
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 11, 40, 64),
        indicatorColor: const Color.fromARGB(255, 25, 68, 103),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white,),
            icon: Icon(Icons.home_outlined, color: Colors.white,), label: 'Inicio',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search, color: Colors.white,),
            icon: Icon(Icons.search_outlined, color: Colors.white,), label: 'Buscar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.favorite_sharp, color: Colors.white,),
            icon: Icon(Icons.favorite_border, color: Colors.white,), label: 'Favoritos',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu_sharp, color: Colors.white,),
            icon: Icon(Icons.menu_rounded, color: Colors.white,), label: 'Otros',
          ),
        ],
      ),
      // Body para agregar los Widget del BottomNavigationBar
      body: <Widget> [
        Homepage(),
        SearchPage(),
        FavoritePage(),
        OtherPage()
      ][currentPageIndex],
    );
  }
}


// Funciones para cambiar entre paginas (Navegación)
// Para ir a la pagina del perfil de usuario
void changeToUserPage(BuildContext context){
  print('Cambiamos a la pagina del usuario');
  Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage()));
}
// Para ir a las preferencias
void changeToPreferencesPage(BuildContext context){
  print('Cambiamos a la pagina de preferencias');
  Navigator.push(context, MaterialPageRoute(builder: (context) => PreferencesPage()));
}