import 'package:flutter/material.dart';
import 'package:my_steam_news/data/services/service_news.dart';
import 'package:my_steam_news/domain/entities/usuario.dart';

//Link para detalles del juego: https://store.steampowered.com/api/appdetails?appids=2651280
//Link para juegos del usuario: http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=*iduser*&format=json
//Link para las noticias de juegos: http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json

//Frano ID = 76561198071742485
//Nachoar ID = 76561199176277858

Color colorCards = Colors.blue;
TextStyle cardTitleTextStyle = TextStyle(fontSize: 50,);

// Pagina Home de la aplicación, la que aparece al ingresar
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {


  //final ServiceNews serviceNew = ServiceNews('http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json');
  //final ServiceNews serviceNew = ServiceNews('http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=');

  //late Future<Juego> futureGame;

  User userprof = User(id: 76561199176277858, idsGames: [], gameCount: 0);
  //User? userprof;

  @override
  void initState(){
    super.initState();
    //serviceNew.getGameID('76561198071742485'); //Se llama al ID del jugador
    ServiceNews serviceNew = ServiceNews('http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=76561198071742485&format=json');
    serviceNew.getUserGamesIds('76561199176277858').then((user) {
      setState(() {
        userprof = user;
      });
      showIdHalfLife(userprof);
    }).catchError((e) {
      print('Error al buscar el usuario $e');
    });
    print('Este es el initState de Home');
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
  return ListView.builder(
    itemCount: 1,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: cardFormat(),
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

//Formato de la Card que muestra la noticia
Card cardFormat(){
  return Card(
    elevation: 4,
    color: colorCards,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Titulo', style: cardTitleTextStyle,),
        Text('Imagen'),
        Text('Fecha'),
      ],
    ),
  );
}


//Funcion de prueba de llamada a la API
void showIdHalfLife(User user){
  print('Juegos del usuario: ${user.idsGames}');
  for (int i = 0; i < user.gameCount; i++) {
    if (user.idsGames[i] == 70) {
      print('Se encontró el juego *Half Life* en la cuenta');
    }
  }
}

