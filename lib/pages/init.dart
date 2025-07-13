import 'package:flutter/material.dart';
import 'dart:math';
import 'package:my_steam_news/domain/entities/juego.dart';
import 'package:my_steam_news/pages/favorite.dart';
import 'package:my_steam_news/pages/home.dart';
import 'package:my_steam_news/pages/others.dart';
import 'package:my_steam_news/pages/preferences.dart';
import 'package:my_steam_news/pages/search.dart';
import 'package:my_steam_news/pages/userprofile.dart';
import 'package:my_steam_news/domain/entities/noticia.dart';
import 'package:my_steam_news/domain/entities/usuario.dart';
import 'package:my_steam_news/data/services/service_news.dart';
import 'package:my_steam_news/data/services/app_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

//Frano ID = 76561198071742485
//Nachoar ID = 76561199176277858

Color colorCards = Colors.blue;
TextStyle cardTitleTextStyle = TextStyle(fontSize: 20);
int quantityOfNewsPerGame = 3;

//Lista de noticias de las novedades
List<Noticia> listGameNewsHome = [];
//Lista de noticias totales de los juegos del usuario
List<Noticia> listGameUserHome = [];
//Lista de juegos aprox de la aplicación
List<Juego> listGamesApp = [];
//Lista de juegos recientemente jugados del usuario
List<Juego> listGamesRecentlyPlay = [];

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

  bool _userLoaded = false;
  //User? userprof;
  User userprof = User(id: 76561199176277858, idsGames: [], gameCount: 0);
  //Lista de noticias por juego
  List<Noticia> listGamesUserNewsPerGame = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> loadIdInDataBase() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedId = prefs.getString('steam_id');

    savedId ??= '0';

    context.read<Appdata>().setUsageID(int.parse(savedId));
  }

  void loadUserGames() {
    if (context.read<Appdata>().usageId == 0) {
      loadIdInDataBase();
    }

    final userId = context.read<Appdata>().usageId.toString();
    userprof.id = context.read<Appdata>().usageId;
    print(context.read<Appdata>().usageId.toString());
    listGameUserHome.clear();
    _userLoaded = false;

    //Conseguir IDs de juegos del usuario
    serviceNew
        .getUserGamesIds(userId)
        .then((user) {
          setState(() {
            userprof = user;
          });

          showIdHalfLife(userprof);

          if (userprof.idsGames.isNotEmpty) {
            for (var idGame in userprof.idsGames) {
              serviceNew
                  .getNews(idGame.toString(), quantityOfNewsPerGame.toString())
                  .then((news) async {
                    final gameDetail = await serviceNew.getGameDetails(
                      idGame.toString(),
                    );

                    // Asigna imágenes a las noticias
                    for (var newPerGame in news) {
                      newPerGame.images = gameDetail.images;
                    }

                    setState(() {
                      listGameUserHome.addAll(news);
                    });

                    print(
                      'Se agregaron ${news.length} noticias con imágenes para ${gameDetail.titulo}',
                    );
                  })
                  .catchError((e) {
                    print('Error al obtener datos para $idGame: $e');
                  });
            }
          }
        })
        .catchError((e) => print('failed to work with API data $e'));

    // Conseguir juegos (nombres e ids) de la app
    serviceNew
        .getGameAppList()
        .then((games) {
          setState(() {
            listGamesApp = games;
          });

<<<<<<< HEAD
      // Conseguir noticias de los primeros 30 juegos de la app
      /*for (int i = games.length - 1; i >= games.length - 10; i--) {
        serviceNew.getNews(games[i].id.toString(), '1').then((gamesNew) {
          setState(() {
            listGameNewsHome.addAll(gamesNew);
          });
        }).catchError((e) => print('failed to load game news'));
      }*/
    }).catchError((e) => print('failed to load game app list'));
=======
          // Conseguir noticias de los primeros 30 juegos de la app
          for (int i = games.length - 1; i >= games.length - 10; i--) {
            serviceNew
                .getNews(games[i].id.toString(), '1')
                .then((gamesNew) {
                  setState(() {
                    listGameNewsHome.addAll(gamesNew);
                  });
                })
                .catchError((e) => print('failed to load game news'));
          }
        })
        .catchError((e) => print('failed to load game app list'));
>>>>>>> 5786ec8e0e9371df69a9753062b3f76b04248016

    //Juegos recientemente jugados
    serviceNew
        .getRecentlyPlayedGames(userprof.id.toString())
        .then((games) {
          setState(() {
            listGamesRecentlyPlay = games;
          });
        })
        .catchError((e) => print('failed to load recently game played'));

    print('Se cargaron los datos de las API');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          65,
        ), // AppBar principal, este nunca cambia y se mantiene en toda la aplicación
        child: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Diferentes botones superiores y el logo de la app: Usuario, Logo, Preferencias
              IconButton(
                icon: const Icon(Icons.person, color: Colors.white, size: 35),
                onPressed: () {
                  changeToUserPage(context);
                },
              ),
              Image.asset(
                'assets/icon/Logo_icon_MySteamNews.png',
                width: 50,
                height: 50,
              ),
              TextButton(
                onPressed: loadUserGames,
                child: Text('Cargar Noticias'),
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white, size: 35),
                onPressed: () {
                  changeToPreferencesPage(context);
                },
              ),
            ],
          ),
        ),
      ),
      // Botones en el pie del inicio
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(255, 11, 40, 64),
        indicatorColor: const Color.fromARGB(255, 25, 68, 103),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined, color: Colors.white),
            label: 'Inicio',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.search, color: Colors.white),
            icon: Icon(Icons.search_outlined, color: Colors.white),
            label: 'Buscar',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.menu_sharp, color: Colors.white),
            icon: Icon(Icons.menu_rounded, color: Colors.white),
            label: 'Otros',
          ),
        ],
      ),
      // Body para agregar los Widget del BottomNavigationBar
      body:
          <Widget>[
            Homepage(
              listGameNewsHome: listGameNewsHome,
              listGameUserHome: listGameUserHome,
              newsFormat: cardFormat,
            ),
            SearchPage(
              gamesToSearch: listGamesApp,
              newsFormat: cardFormat,
              serviceNew: serviceNew,
            ),
            OtherPage(
              newsFormat: cardFormat,
              gamesPlayed: listGamesRecentlyPlay,
            ),
          ][currentPageIndex],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_userLoaded) return;
    _userLoaded = true;
    loadUserGames();
  }
}

// Funciones para cambiar entre paginas (Navegación)
// Para ir a la pagina del perfil de usuario
void changeToUserPage(BuildContext context) {
  print('Cambiamos a la pagina del usuario');
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => UserProfilePage()),
  );
}

// Para ir a las preferencias
void changeToPreferencesPage(BuildContext context) {
  print('Cambiamos a la pagina de preferencias');
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PreferencesPage()),
  );
}

//Formato de Card para mostrar las noticias
//Formato de la Card que muestra la noticia
Widget cardFormat(Noticia noticia) {
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
            const SizedBox(height: 6),
            Center(child: imageGameCard(noticia)),
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

Future<void> _launchUrl(String url) async {
  final Uri url1 = Uri.parse(url);

  if (!await launchUrl(url1)) {
    throw Exception('Could not launch $url');
  }
}

//funcion para inicializar la imagen
Widget imageGameCard(Noticia noticia) {
  final List<String> imagenes = noticia.images ?? [];
  if (imagenes.isNotEmpty) {
    final randomImage = imagenes[Random().nextInt(imagenes.length)];
    print('Esta es la imagen del juego $randomImage');
    return Image.network(randomImage);
  } else {
    return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
  }
}
