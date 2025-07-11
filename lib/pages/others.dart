import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/service_news.dart';
import 'package:my_steam_news/domain/entities/juego.dart';
import 'package:my_steam_news/domain/entities/noticia.dart';

class OtherPage extends StatefulWidget{
  const OtherPage({super.key, required this.newsFormat, required this.gamesPlayed});

  final Widget Function(Noticia) newsFormat;
  final List<Juego> gamesPlayed;

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage>{

  @override
  Widget build(BuildContext context){
    return Center(
      child: DefaultTabController(
        length: 2, 
        child: Scaffold(
          appBar: PreferredSize(preferredSize:Size.fromHeight(60), 
            child: AppBar(
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Jugados recientemente'), //Lista de desados [Cambiado por no tener acceso]
                  Tab(text: 'Juegos con más logros'),              //Seguidos [Cambiado por no tener acceso]
                ],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color.fromARGB(255, 250, 253, 255),
                labelColor: Color.fromARGB(255, 250, 253, 255),
              ),
              backgroundColor: const Color.fromARGB(253, 14, 56, 90),
            ),
          ),
          body: TabBarView(children: [
            recentlyPlayedPageShow(widget.newsFormat, widget.gamesPlayed),
            achievementsGamesPageShow(),
          ])
        )
      ),
    );
  }
}


// Funciones que muestran el contenido en pantalla
// Para mostrar las noticias de los juegos principales del usuario
Widget recentlyPlayedPageShow(Widget Function(Noticia) newsFormat, List<Juego> games){
  print('Estamos en la pagina de la Jugados recientemente del usuario');
  return Scaffold(
    appBar: AppBar(
      title: Text('Tus jugados recientemente', style: TextStyle(color: Colors.white),),
      backgroundColor: const Color.fromARGB(253, 14, 56, 90),
    ),
    body: ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        return ListTile(
        title: Text(games[index].titulo, style: TextStyle(color: Colors.blueAccent),),
        onTap: () {   
          Navigator.push(context, MaterialPageRoute(builder: (context) => GamesPlayed(cardFormat: newsFormat, game: games[index])));
        },
      );
      }
    ),
  );
}
// Para mostrar las noticias más recientes de varios juegos (populares o no)
Widget achievementsGamesPageShow(){
  print('Estamos en la pagina de los Juegos con más logros del usuario');
  return Center(
    child: Text('Page in devolpment . . . papu', style: TextStyle(color: Colors.white),),
  );
}

//Para mostrar las noticias del juego tras seleccionar
class GamesPlayed extends StatefulWidget {
  const GamesPlayed({super.key, required this.cardFormat, required this.game});

  final Widget Function(Noticia) cardFormat;
  final Juego game; 

  @override
  State<GamesPlayed> createState() => _GamesPlayedState();
}

class _GamesPlayedState extends State<GamesPlayed> {
  
  List<Noticia> listNews = [];
  ServiceNews serviceNew = ServiceNews();

  @override
  void initState() {
    super.initState();
    serviceNew.getNews(widget.game.id.toString(), '20').then((newsOfThisGame) {
      serviceNew.getGameDetails(widget.game.id.toString()).then((gameDetail) {
        for (var noticia in newsOfThisGame) {
          noticia.images = gameDetail.images;
        }

        setState(() {
          listNews = newsOfThisGame;
        });

        print('Noticias cargadas con imágenes para ${widget.game.titulo}');
      });
    }).catchError((e) => print('Error al cargar noticias para ${widget.game.titulo}: $e'));

    print('Entrando a la pantalla NewsGame');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias de ${widget.game.titulo}', style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
      ),
      body: ListView.builder(
        itemCount: listNews.length,
        itemBuilder: (context, index) {
          print('Renderizando noticia en índice $index');
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.cardFormat(listNews[index]),
          );
        },
      ),
    );
  }
}

