class Juego {
  final int? id;
  final String titulo;
  final List<String> images;

  Juego({this.id, required this.titulo, required this.images});

  factory Juego.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'id': int id, 'titulo': String titulo, 'images': List<String> images} =>
        Juego(id: id, titulo: titulo, images: images),
      _ => throw const FormatException('Failed to load Juego'),
    };
  }
}
