import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:http/http.dart' as http;

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
  // http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=XXXXXXXXXXXXXXXXX&steamid=76561197960434622&format=json
  Future<List<String>> getGameID(String idUser) async {
    final url = Uri.parse('http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=$idUser&format=json');
    final List<String> idsGame = [];

    final response = await http.get(url);

    if(response.statusCode == 200){
            
      return idsGame;
    }
    else{
      print('User not found, $idUser doesn´t exit');
      throw Exception('Failed to load news');
    }
  }

  /*Future<String> getImagesGame(String searchQuery) async {

  }*/
}