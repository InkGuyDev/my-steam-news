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
                  Tab(text: 'Explorar'), //Seguidos [Cambiado por no tener acceso]
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
            explorePageShow(),
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
    body: ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 80,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Opacity(
                      opacity: 0.7,
                      child: imageBackground(games, index),
                    )
                  ),
                ),
                Positioned.fill(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(0, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                    onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => GamesPlayed(cardFormat: newsFormat, game: games[index]))); },
                    child: Stack(
                      children: [
                        Text(
                          games[index].titulo,
                          style: TextStyle(
                            fontSize: 24,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 3.5
                              ..color = const Color.fromARGB(160, 22, 28, 36),
                          ),
                        ),
                        Text(
                          games[index].titulo,
                          style: TextStyle(
                            fontSize: 24,
                            color: const Color.fromARGB(255, 255, 255, 255)
                          ),
                        ),
                      ],
                    ),
                    
                    //Text(games[index].titulo, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0), fontSize: 24),),
                  )
                ),
              ],
            ),
          ),
        );
      }
    ),
  );
}


//Para mostrar las noticias más recientes de varios juegos (populares o no)
Widget explorePageShow(){
  print('Estamos en la pagina de los Juegos con más logros del usuario');
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(148, 14, 56, 90),
        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12),),
        flexibleSpace: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5), // Ajusta si quieres mover más abajo
            child: Stack(
              children: [
                Text(
                  'Explora nuevas noticias de \njuegos a partir de tus gustos',
                  style: TextStyle(
                    fontSize: 24,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3.5
                      ..color = const Color.fromARGB(160, 22, 28, 36),
                  ),
                ),
                Text(
                  'Explora nuevas noticias de \njuegos a partir de tus gustos',
                  style: TextStyle(
                    fontSize: 24,
                    color: const Color.fromARGB(255, 255, 255, 255)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    body: ListView(
      children: [
        ExpansionTile(
          tilePadding: EdgeInsets.all(15),
          collapsedBackgroundColor: const Color.fromARGB(6, 255, 255, 255),
          collapsedTextColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: const Color.fromARGB(70, 255, 255, 255),
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Text("Género", style: TextStyle(fontSize: 20),),
          subtitle: Text('Aventura, Acción, Simulación, etc.'),
          leading: Icon(Icons.menu, size: 35,),
          children: optionsGender(),
        ),
        ExpansionTile(
          tilePadding: EdgeInsets.all(15),
          collapsedBackgroundColor: const Color.fromARGB(6, 255, 255, 255),
          collapsedTextColor: Colors.white,
          collapsedIconColor: Colors.white,
          backgroundColor: const Color.fromARGB(70, 255, 255, 255),
          textColor: Colors.white,
          iconColor: Colors.white,
          title: Text("Categorías", style: TextStyle(fontSize: 20),),
          subtitle: Text('Single-player, Full controller support etc.'),
          leading: Icon(Icons.menu, size: 35,),
          children: optionsGender(),
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color.fromARGB(6, 255, 255, 255),
          ),
          child: Center(
            child: ListTile(
              leading: Icon(Icons.menu, color: Colors.white, size: 35,), // mismo ícono que arriba
              title: Text(
                "Proximos lanzamientos",
                style: TextStyle(fontSize: 20, color: Colors.white,),
              ),
              onTap: () {},
            ),
          )
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: const Color.fromARGB(6, 255, 255, 255),
          ),
          child: Center(
            child: ListTile(
              leading: Icon(Icons.menu, color: Colors.white, size: 35,), // mismo ícono que arriba
              title: Text(
                "Gratuitos",
                style: TextStyle(fontSize: 20, color: Colors.white,),
              ),
              onTap: () {},
            ),
          )
        ),
      ],
    ),
  );
}

List<ElevatedButton> optionsGender(){
  return [
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Action", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Adventure", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Animation & Modeling", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Anime", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Casual", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Fighting", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Free to Play", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Horror", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Indie", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Music", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Narrative", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Platformer", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Puzzle", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Racing", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("RPG", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Shooter", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Simulation", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Sports", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Strategy", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Survival", style: TextStyle(color: Colors.white))),
    ElevatedButton(onPressed: () {}, style: ElevatedButton.styleFrom(minimumSize: Size(300, 42), backgroundColor: const Color.fromARGB(148, 14, 56, 90)), child: Text("Video Production", style: TextStyle(color: Colors.white))),
  ];
}

//Para mostrar las imagenes del background
Widget imageBackground(List<Juego> games, int index){
  return Image.network(
    'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/${games[index].id}/header.jpg?t=1720558643',
    fit: BoxFit.fitWidth,
    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      return const Icon(Icons.broken_image, size: 70, color: Colors.grey);
    },
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
        return const Center(
        child: SizedBox(
          width: 24, 
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    },
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

    print('Entrando a la pantalla GamesPlayed');
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.game.titulo}', style: TextStyle(color: Colors.white),),
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