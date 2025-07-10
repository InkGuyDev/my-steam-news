import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/service_news.dart';
import 'package:my_steam_news/domain/entities/noticia.dart';
import 'package:my_steam_news/domain/entities/usuario.dart';
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
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  ServiceNews serviceNew = ServiceNews();

  //User? userprof;
  User userprof = User(id: 76561199176277858, idsGames: [], gameCount: 0);
  //Lista de noticias por juego
  List<Noticia> listGamesUserNewsPerGame = [];

  @override
  void initState() {
    super.initState();
    print('Este es el initState de Home');

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
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: AppBar(
              bottom: const TabBar(
                tabs: [Tab(text: 'Tus Juegos'), Tab(text: 'Novedades')],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color.fromARGB(255, 250, 253, 255),
                labelColor: Color.fromARGB(255, 250, 253, 255),
              ),
              backgroundColor: const Color.fromARGB(253, 14, 56, 90),
            ),
          ),
          body: TabBarView(children: [yourGamesPageShow(), newsPageShow()]),
        ),
      ),
    );
  }
}

// Funciones que muestran el contenido en pantalla
// Para mostrar las noticias de los juegos principales del usuario
Widget yourGamesPageShow() {
  return ListView.builder(
    itemCount: listGameHome.length,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardFormat(listGameHome[index]),
      );
    },
  );
}

// Para mostrar las noticias más recientes de varios juegos (populares o no)
Widget newsPageShow() {
  print('Estamos en la pagina de novedades del usuario');
  return Center(
    child: Text(
      'Page in devolpment . . . papu',
      style: TextStyle(color: Colors.white),
    ),
  );
}

//Formato de la Card que muestra la noticia
Card cardFormat(Noticia noticia) {
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

//Funcion de prueba de llamada a la API
void showIdHalfLife(User user) {
  print('Juegos del usuario: ${user.idsGames}');
  for (int i = 0; i < user.gameCount; i++) {
    if (user.idsGames[i] == 70) {
      print('Se encontró el juego *Half Life* en la cuenta');
    }
  }
}
