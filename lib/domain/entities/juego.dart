class Juego {
  final int? id;
  final String titulo;
  List<String>? images;

  Juego({this.id, required this.titulo, this.images});

  factory Juego.fromJson(Map<String, dynamic> json, String appId) {
    final data = json[appId]?['data'];
    if (data == null) {
      //throw const FormatException('No data found for app');
      print('No se encontraron detalles para el juego con appId: $appId');
      return Juego(id: int.tryParse(appId), titulo: 'lost game', images: []);
    }

    final screenshots = data['screenshots'] as List<dynamic>;

    return Juego(
      id: data['steam_appid'],
      titulo: data['name'],
      images: screenshots != null
        ? screenshots.map((e) => e['path_full'] as String).toList()
        : [],
    );
  }

  factory Juego.fromJsonList(Map<String, dynamic> json) {
    return Juego(
      id: json['appid'],
      titulo: json['name'] ?? '',
    );
  }
}
