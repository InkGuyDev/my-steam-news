import 'package:http/http.dart' as http;

class ServiceNews {
  String urlRequest;

  ServiceNews(this.urlRequest);

  Future<String> getNews(String searchQuery) async {
    //final String finalUrlRequest = urlRequest + '=$searchQuery';//await http.get(Uri.parse(urlRequest),);

    final url = Uri.parse('$urlRequest$searchQuery&format=json');
    //final url1 = Uri.parse('http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=DAF9764CEB1934D64B009F26CF5F8F63&steamid=76561199484084882&format=json');

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
}