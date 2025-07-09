import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/service_news.dart';

//Link para detalles del juego: https://store.steampowered.com/api/appdetails?appids=2651280
// Pagina Home de la aplicación, la que aparece al ingresar
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {

  final ServiceNews serviceNew = ServiceNews('http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json');
  //final ServiceNews serviceNew = ServiceNews('http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=');

  @override
  void initState(){
    super.initState();
    serviceNew.getNews('76561198071742485'); //Se llama al ID del jugador
  }

  //Lista de noticias
  final List<Card> listGamesUserNews = [];

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
            yourGamesPageShow(listGamesUserNews),
            newsPageShow(),
          ])
        )
      ),
    );
  }
}


// Funciones que muestran el contenido en pantalla
// Para mostrar las noticias de los juegos principales del usuario
Widget yourGamesPageShow(List<Card> listGamesUserNews){
  /*print('Estamos en la pagina de los juegos principales del usuario');
  return Center(
    child: Text('Page in devolpment . . . papu', style: TextStyle(color: Colors.white)),
  );*/
  return ListView.builder(
    itemCount: listGamesUserNews.length,
    itemBuilder: (context, index) {
      return ListTile(

      );
    }
  );
}
// Para mostrar las noticias más recientes de varios juegos (populares o no)
Widget newsPageShow(){
  print('Estamos en la pagina de novedades del usuario');
  return Center(
    child: Text('Page in devolpment . . . papu', style: TextStyle(color: Colors.white),),
  );
}

//Formato de la Card
Card cardFormat(){
  return Card(

  );
}

