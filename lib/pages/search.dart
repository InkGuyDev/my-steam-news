import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_steam_news/data/services/service_news.dart';
import 'package:my_steam_news/domain/entities/juego.dart';
import 'package:my_steam_news/domain/entities/noticia.dart';
import 'package:url_launcher/url_launcher.dart';

//1174180 = Red dead redemption 2
//2322010 = God of war Ragnarok
//367520 = Hollow Knigth
//413150 = Stradew Valley
//1364780 = Street Fighter 6
//2767030 = Marvel Rivals

class GameSearch extends SearchDelegate<String> {
  
  final List<Juego> games;
  final Widget Function(Noticia) newsFormat;
  
  GameSearch(this.games, this.newsFormat);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            colorScheme.brightness == Brightness.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
        backgroundColor:
            colorScheme.brightness == Brightness.dark ? Colors.white : const Color.fromARGB(255, 11, 40, 64),
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white ),
        titleTextStyle: theme.textTheme.titleLarge,
        toolbarTextStyle: theme.textTheme.bodyMedium,
      ),
      inputDecorationTheme:
          searchFieldDecorationTheme ??
          InputDecorationTheme(
            hintStyle: searchFieldStyle ?? theme.inputDecorationTheme.hintStyle,
            border: InputBorder.none,
          ),
    );
  }

  @override
  String get searchFieldLabel => 'Buscar juego...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(
    color: Colors.white,
    fontSize: 18,
  );

  //Acciones del boton de la derecha
  @override
  List<Widget> buildActions(BuildContext context){
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  //Para volver y cerrar la busqueda
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }


  //Resultados de la busqueda
  @override
  Widget buildResults(BuildContext context){
    final results = games.where((gameName) => gameName.titulo.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(results[index].titulo, style: TextStyle(color: Colors.white),),
        onTap: () {
          close(context, results[index].titulo);

          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsGame(cardFormat: newsFormat, game: results[index])));
        },
      )
    );
  }


  //Sugerencias en tiempo real
  @override
  Widget buildSuggestions(BuildContext context){
    final suggestions = games.where((gameName) => gameName.titulo.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (_, index) => ListTile(
        title: Text(suggestions[index].titulo, style: TextStyle(color: Colors.blueAccent),),
        onTap: () {
          query = suggestions[index].titulo; 
          showSuggestions(context);       
        },
      ),
    );
  }
}


class SearchPage extends StatelessWidget{
  const SearchPage({super.key, required this.gamesToSearch, required this.newsFormat, required this.serviceNew});

  final List<Juego> gamesToSearch;
  final Widget Function(Noticia) newsFormat;
  final ServiceNews serviceNew;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 25, 68, 103),),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: GameSearch(gamesToSearch, newsFormat),
              );
            }, 
            child: Row(
              children: [
                Icon(Icons.search),
                SizedBox(width: 15,),
                Text('Buscar juego...'),
              ],
            ),
          ),
        backgroundColor: const Color.fromARGB(253, 14, 56, 90),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Card( //Text('Search Page on development process . . . papu', style: TextStyle(color: Colors.white),),
              elevation: 6,
              color: const Color.fromARGB(253, 14, 56, 90),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: InkWell(
                onTap: () {
                  launchSteamWeb();
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('¡Revisa las novedades de Steam!', style: TextStyle(fontSize: 23),),
                      SizedBox(height: 15),
                      ImageSlider(imageUrls: [
                        'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/1174180/header.jpg?t=1720558643',
                        'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/2322010/header.jpg?t=1720558643',
                        'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/367520/header.jpg?t=1720558643',
                        'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/413150/header.jpg?t=1720558643',
                        'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/1364780/header.jpg?t=1720558643',
                        'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/2767030/header.jpg?t=1720558643'
                      ]),
                      SizedBox(height: 15),
                      Text('Novedades en juegos y ofertas'),
                    ],
                  ),
                ),
              )
            ),
          ],
        )
      ),
    );
  }
}

//Para dirigirse a la pagina de principal de Steam
Future<void> launchSteamWeb() async {
  final Uri url = Uri.parse('https://store.steampowered.com');

  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

//Para pasar las imagenes simuladas
class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;
  const ImageSlider({super.key, required this.imageUrls});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 360,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        itemBuilder: (_, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(widget.imageUrls[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}


//Para mostrar las noticias del juego tras buscar
class NewsGame extends StatefulWidget {
  const NewsGame({super.key, required this.cardFormat, required this.game});

  final Widget Function(Noticia) cardFormat;
  final Juego game; 

  @override
  State<NewsGame> createState() => _NewsGameState();
}

class _NewsGameState extends State<NewsGame> {
  
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
