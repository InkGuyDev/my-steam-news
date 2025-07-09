import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_steam_news/domain/entities/usuario.dart';

//Link para detalles del juego: https://store.steampowered.com/api/appdetails?appids=2651280
//Link para juegos del usuario: http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=*iduser*&format=json
//Link para las noticias de juegos: http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json
//Key = DAF9764CEB1934D64B009F26CF5F8F63

class ServiceNews {
  String urlRequest;

  ServiceNews(this.urlRequest);

  Future<String> getNews(String searchQuery) async {
    //final String finalUrlRequest = urlRequest + '=$searchQuery';//await http.get(Uri.parse(urlRequest),);

    //final url = Uri.parse('$urlRequest$searchQuery&format=json');
    //final url1 = Uri.parse('http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=76561199484084882&format=json');
    final url = Uri.parse('http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=1&maxlength=300&format=json');

    final response = await http.get(url);

    print('Response status: ${response.statusCode}');

    if(response.statusCode == 200){

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return response.body;
    }
    else
    {
      throw Exception('Failed to load news');
    }
  }

  //Para obtener la ID de los juegos
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
}