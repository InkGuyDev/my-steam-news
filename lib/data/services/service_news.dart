import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_steam_news/domain/entities/juego.dart';
import 'package:my_steam_news/domain/entities/noticia.dart';
import 'package:my_steam_news/domain/entities/usuario.dart';

//Link para lista de juegos de la plataforma: https://api.steampowered.com/ISteamApps/GetAppList/v2/
//Link para detalles del juego: https://store.steampowered.com/api/appdetails?appids=2651280
//Link para juegos del usuario: http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=*iduser*&format=json
//Link para las noticias de juegos: http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json
//Link para jugados reciente mente: http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/?key=XXXXXXXXXXXXXXXXX&steamid=76561197960434622&format=json
//Link para obtener los datos del perfil del usuario: http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamids=
//Key = DAF9764CEB1934D64B009F26CF5F8F63

class ServiceNews {
  //Para obtener las noticias de los juegos
  Future<List<Noticia>> getNews(
    String searchQuery,
    String quantityOfNews,
  ) async {
    final url = Uri.parse(
      'http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=$searchQuery&count=$quantityOfNews&maxlength=300&format=json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> newsJson = data['appnews']['newsitems'];

      return newsJson.map((json) => Noticia.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }

  //Para obtener la ID de los juegos del usuario
  Future<User> getUserGamesIds(String idUser) async {
    final url = Uri.parse(
      'http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=$idUser&format=json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    } else {
      throw Exception('failed to load user games');
    }
  }

  //Para obtener los datos del perfil del usuario de Steam
  Future<User> getUserProfile(String steamId) async {
    final url = Uri.parse(
      'http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamids=$steamId',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return User.fromJson(json);
    } else {
      throw Exception('failed to load user');
    }
  }

  //Para obtener información de los juegos (IDs e Imagenes)
  Future<Juego> getGameDetails(String idGame) async {
    final url = Uri.parse(
      'https://store.steampowered.com/api/appdetails?appids=$idGame',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Juego.fromJson(json, idGame);
    } else {
      //throw Exception('failed to load game details');
      return Juego(id: 000000, titulo: 'lost game', images: []);
    }
  }

  //Para obtener los juegos de la app (nombre e ID)
  Future<List<Juego>> getGameAppList() async {
    final url = Uri.parse(
      'https://api.steampowered.com/ISteamApps/GetAppList/v2/',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> gameAppList = data['applist']['apps'];

      return gameAppList.map((json) => Juego.fromJsonList(json)).toList();
    } else {
      throw Exception('failed to load game list');
    }
  }

  //Para la lista de juegos recientemente jugados
  Future<List<Juego>> getRecentlyPlayedGames(String idUser) async {
    final url = Uri.parse(
      'http://api.steampowered.com/IPlayerService/GetRecentlyPlayedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=$idUser&format=json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> gameRecentlyList = data['response']['games'];

      return gameRecentlyList.map((json) => Juego.fromJsonList(json)).toList();
    } else {
      throw Exception('failed to load game list');
    }
  }
}
