import 'package:http/http.dart' as http;

class ServiceNews {
  String urlRequest;

  ServiceNews(this.urlRequest);

  Future<String> getNews(String searchQuery) async {
    //final String finalUrlRequest = urlRequest + '=$searchQuery';//await http.get(Uri.parse(urlRequest),);

    //final url = Uri.parse('$urlRequest/=$searchQuery');
    final url1 = Uri.parse('http://api.steampowered.com/ISteamNews/GetNewsForApp/v0002/?appid=440&count=3&maxlength=300&format=json');

    final response = await http.get(url1);

    if(response.statusCode == 200){

      print('Response status: ${response.statusCode}');

      return response.body;
    }
    else
    {
      throw Exception('Failed to load news');
    }
  }
}