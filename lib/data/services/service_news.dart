import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_steam_news/domain/entities/noticia.dart';
import 'package:my_steam_news/domain/entities/usuario.dart';

//Link para detalles del juego: https://store.steampowered.com/api/appdetails?appids=2651280
//Link para juegos del usuario: http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=*iduser*&format=json
//Link para las noticias de juegos: http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json
//Key = DAF9764CEB1934D64B009F26CF5F8F63

class ServiceNews {
  //String urlRequest;

  //ServiceNews(this.urlRequest);

  //Para obtener las noticias de los juegos
  Future<List<Noticia>> getNews(String searchQuery, String quantityOfNews) async {

    final url = Uri.parse('http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=$searchQuery&count=$quantityOfNews&maxlength=300&format=json');

    final response = await http.get(url);

    if(response.statusCode == 200){

      final data = jsonDecode(response.body);
      final List<dynamic> newsJson = data['appnews']['newsitems'];

      return newsJson.map((json) => Noticia.fromJson(json)).toList();
    }
    else
    {
      throw Exception('Failed to load news');
    }
  }

  //Para obtener la ID de los juegos del usuario
  Future<User> getUserGamesIds(String idUser) async {

    final url = Uri.parse('http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=$idUser&format=json');
  
    final response = await http.get(url);

    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    }
    else{
      throw Exception('failed to load user games');
    }
  }


  //Para obtener las imagenes de los juegos (detalles)
}