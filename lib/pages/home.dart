import 'package:flutter/material.dart';
import 'package:my_steam_news/domain/entities/noticia.dart';
import 'package:my_steam_news/domain/entities/usuario.dart';

// Pagina Home de la aplicación, la que aparece al ingresar
class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.newsFormat, required this.listGameUserHome, required this.listGameNewsHome});
  
  final Widget Function(Noticia) newsFormat;
  final List<Noticia> listGameUserHome;
  final List<Noticia> listGameNewsHome;

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {


  @override
  void initState() {
    super.initState();
    print('Este es el initState de Home');
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
          body: TabBarView(
            children: [
              yourGamesPageShow(widget.listGameUserHome, widget.newsFormat), 
              newsPageShow(widget.listGameNewsHome, widget.newsFormat)
            ]
          ),
        ),
      ),
    );
  }
}

// Para mostrar las noticias de los juegos principales del usuario
Widget yourGamesPageShow(List<Noticia> listGameHome, Widget Function(Noticia) cardFormat) {
  print('Cantidad de noticias en listGameHome: ${listGameHome.length}');
  return ListView.builder(
    itemCount: listGameHome.length,
    itemBuilder: (context, index) {
      print('Renderizando noticia en índice $index');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardFormat(listGameHome[index]),
      );
    },
  );
}

// Para mostrar las noticias más recientes de varios juegos (populares o no)
Widget newsPageShow(List<Noticia> listGameNewsPage, Widget Function(Noticia) cardFormat) {
  print('Estamos en la pagina de novedades del usuario');
  return ListView.builder(
    itemCount: listGameNewsPage.length,
    itemBuilder: (context, index) {
      print('Renderizando noticia en índice $index');
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardFormat(listGameNewsPage[index]),
      );
    },
  );
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
