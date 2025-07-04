import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/service_news.dart';


// Pagina Home de la aplicación, la que aparece al ingresar
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {

  late ServiceNews serviceNew;

  @override
  void initState(){
    super.initState();
    serviceNew.getNews('http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json');
  }

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

