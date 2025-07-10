import 'package:flutter/material.dart';
import 'package:my_steam_news/pages/favorite.dart';
import 'package:my_steam_news/pages/home.dart';
import 'package:my_steam_news/pages/others.dart';
import 'package:my_steam_news/pages/preferences.dart';
import 'package:my_steam_news/pages/search.dart';
import 'package:my_steam_news/pages/userprofile.dart';
import 'package:my_steam_news/domain/entities/noticia.dart';
import 'package:my_steam_news/domain/entities/usuario.dart';
import 'package:my_steam_news/data/services/service_news.dart';
import 'package:url_launcher/url_launcher.dart';



//Link para detalles del juego: https://store.steampowered.com/api/appdetails?appids=2651280
//Link para juegos del usuario: http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=*iduser*&format=json
//Link para las noticias de juegos: http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json

//Frano ID = 76561198071742485
//Nachoar ID = 76561199176277858

Color colorCards = Colors.blue;
TextStyle cardTitleTextStyle = TextStyle(fontSize: 30);
int quantityOfNewsPerGame = 3;

//Lista de noticias totales de los juegos del usuario
List<Noticia> listGameHome = [];


// Pagina Home de la aplicación, la que aparece al ingresar
class InitPage extends StatefulWidget {
  const InitPage({super.key, required this.title});
  final String title;

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int currentPageIndex = 0;

  ServiceNews serviceNew = ServiceNews();

  //User? userprof;
  User userprof = User(id: 76561199176277858, idsGames: [], gameCount: 0);
  //Lista de noticias por juego
  List<Noticia> listGamesUserNewsPerGame = [];

  @override
  void initState(){
    super.initState();

    //Conseguir IDs del usuario
    serviceNew
      .getUserGamesIds(userprof.id.toString())
      .then((user) {
        setState(() {
          userprof = user;
        });

        showIdHalfLife(userprof);

        if (userprof.idsGames.isNotEmpty) {
          for (var idGame in userprof.idsGames) {
            serviceNew
                .getNews(idGame.toString(), quantityOfNewsPerGame.toString())
                .then((news) {
                  setState(() {
                    listGamesUserNewsPerGame = news;
                    print('${listGamesUserNewsPerGame.length}');
                    for (var gameNews in listGamesUserNewsPerGame) {
                      listGameHome.add(gameNews);
                    }
                  });
                });
          }
        }
      })
      .catchError((e) => print('failed to work with API data $e'));
    /*listGameHome = [
      Noticia(
        gid: '70',
        title: 'Half-Life 3 confirmado',
        date: '2025-07-10',
        feedLabel: 'Valve News',
        url: 'https://store.steampowered.com/app/70',
      ),
      Noticia(
        gid: '400',
        title: 'Portal 3 en desarrollo',
        date: '2025-07-09',
        feedLabel: 'GabeN Oficial',
        url: 'https://store.steampowered.com/app/400',
      ),
    ];*/
    print('Se cargaron los datos de las API');
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
        Homepage(listGameNewsHome: listGameHome, newsFormat: cardFormat,),
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

//Formato de Card para mostrar las noticias
//Formato de la Card que muestra la noticia
Widget cardFormat(Noticia noticia) {
  print('Se deberian ver algunas noticias, las ves tú?');
  return Card(
    elevation: 4,
    color: colorCards,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: InkWell(
      onTap: () {
        _launchUrl(noticia.url); //con url_launcher
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              noticia.feedLabel,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            const SizedBox(height: 6),
            Text(noticia.title, style: cardTitleTextStyle),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  noticia.date,
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // Compartir noticia
                  },
                  icon: const Icon(Icons.share, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> _launchUrl(String _url) async {
  final Uri _url1 = Uri.parse(_url);

  if (!await launchUrl(_url1)) {
    throw Exception('Could not launch $_url');
  }
}