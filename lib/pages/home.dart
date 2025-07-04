import 'package:flutter/material.dart';
import 'package:my_steam_news/pages/favorite.dart';
import 'package:my_steam_news/pages/others.dart';
import 'package:my_steam_news/pages/preferences.dart';
import 'package:my_steam_news/pages/search.dart';
import 'package:my_steam_news/pages/userprofile.dart';


// Pagina Home de la aplicación, la que aparece al ingresar
class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});
  final String title;

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {

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
          backgroundColor: const Color.fromARGB(255, 11, 40, 64),
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
        homePageShow(),
        SearchPage(),
        FavoritePage(),
        OtherPage()
      ][currentPageIndex],
    );
  }
}

// Contenido Principal de la Pagina Home
Widget homePageShow(){
  return Center(
    child: DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: PreferredSize(preferredSize:Size.fromHeight(60), 
          child: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Tus Juegos'),
                Tab(text: 'Novedades'),
              ],
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Color.fromARGB(255, 250, 253, 255),
              labelColor: Color.fromARGB(255, 250, 253, 255),
            ),
            backgroundColor: const Color.fromARGB(253, 14, 56, 90),
          ),
        ),
        body: TabBarView(children: [
          yourGamesPageShow(),
          newsPageShow(),
        ])
      )
    ),
  );
}

// Funciones que muestran el contenido en pantalla
// Para mostrar las noticias de los juegos principales del usuario
Widget yourGamesPageShow(){
  print('Estamos en la pagina de los juegos principales del usuario');
  return Center(
    child: Text('Page in devolpment . . . papu', style: TextStyle(color: Colors.white)),
  );
}
// Para mostrar las noticias más recientes de varios juegos (populares o no)
Widget newsPageShow(){
  print('Estamos en la pagina de novedades del usuario');
  return Center(
    child: Text('Page in devolpment . . . papu', style: TextStyle(color: Colors.white),),
  );
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